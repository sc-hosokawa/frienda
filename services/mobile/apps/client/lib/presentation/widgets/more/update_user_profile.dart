import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:client/presentation/providers/client_provider.dart';
import 'package:client/presentation/providers/user_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class UpdateUserProfile extends ConsumerStatefulWidget {
  const UpdateUserProfile({super.key});

  @override
  ConsumerState<UpdateUserProfile> createState() => _UpdateUserProfileState();
}

class _UpdateUserProfileState extends ConsumerState<UpdateUserProfile> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _greetingController;
  late TextEditingController _skillController;
  late TextEditingController _xHandleController;
  late TextEditingController _instagramHandleController;
  late TextEditingController _fbHandleController;
  late TextEditingController _evmAddrController;
  String? _selectedRole;
  String? _selectedPrimaryRole;
  String? _interestOffer;
  File? _imageFile;
  String? _currentImageUrl;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _greetingController = TextEditingController();
    _skillController = TextEditingController();
    _xHandleController = TextEditingController();
    _instagramHandleController = TextEditingController();
    _fbHandleController = TextEditingController();
    _evmAddrController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final userId = ref.read(userProvider)?.id;
      if (userId == null) return;

      final result = await GraphQLProvider.of(context).value.query(
            QueryOptions(
              document: gql('''
            query GetUserData(\$userId: String!) {
              getUserData(userId: \$userId) {
                id
                name
                imageUrl
                evmAddr
                role
                primaryRole
                greeting
                skill
                xHandle
                instagramHandle
                fbHandle
                interestOffer
                createdAt
                belongsToArtists {
                  id
                  name
                  imageUrl
                }
                primaryArtist {
                  id
                  name
                  imageUrl
                }
              }
            }
          '''),
              variables: {
                'userId': userId,
              },
              fetchPolicy: FetchPolicy.networkOnly,
            ),
          );

      if (result.hasException) {
        throw result.exception!;
      }

      final userData = result.data?['getUserData'];
      if (userData != null) {
        setState(() {
          _nameController.text = userData['name'] ?? '';
          _greetingController.text = userData['greeting'] ?? '';
          _skillController.text = userData['skill'] ?? '';
          _xHandleController.text = userData['xHandle'] ?? '';
          _instagramHandleController.text = userData['instagramHandle'] ?? '';
          _fbHandleController.text = userData['fbHandle'] ?? '';
          _evmAddrController.text = userData['evmAddr'] ?? '';
          _selectedRole = userData['role'];
          _selectedPrimaryRole = userData['primaryRole'];
          _interestOffer = userData['interestOffer'];
          _currentImageUrl = userData['imageUrl'];
        });
      }
    } catch (e) {
      // エラーハンドリングを遅延実行
      Future.microtask(() {
        if (mounted) {
          // Widgetがまだ存在することを確認
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('プロフィールの取得に失敗しました: ${e.toString()}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      });
    }
  }

  Future<String?> _uploadImageToFirebase(File imageFile) async {
    try {
      final userId = ref.read(userProvider)?.id;
      if (userId == null) return null;

      // Generate a unique filename using timestamp
      final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final String filename = '${userId}_$timestamp.jpg';

      // Upload to Firebase Storage with correct path structure
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('user_images')
          .child(userId) // ユーザーIDのフォルダを作成
          .child(filename);

      // Upload with metadata
      final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'userId': userId},
      );

      // ファイルをアップロード
      final uploadTask = storageRef.putFile(imageFile, metadata);

      // アップロードの進行状況を監視
      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        final progress = snapshot.bytesTransferred / snapshot.totalBytes;
        // TODO: 必要にじてプログレス表示を実装
      });

      // アップロード完了を待機
      await uploadTask;

      // アップロードされた画像のURLを取得
      final downloadUrl = await storageRef.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('画像のアップロードに失敗しました: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return null;
    }
  }

  Future<void> _deleteOldImage(String imageUrl) async {
    try {
      // URLからファイルパスを抽出
      // 例: https://firebasestorage.googleapis.com/v0/b/frienda-auth-test1.appspot.com/o/user_images%2F0JxH0rRFWHgKuty6CzwmcpSQ7bo1%2F0JxH0rRFWHgKuty6CzwmcpSQ7bo1_1730350296623.jpg?alt=media&token=...
      final uri = Uri.parse(imageUrl);
      final path = Uri.decodeFull(uri.path);
      // /v0/b/frienda-auth-test1.appspot.com/o/user_images/0JxH0rRFWHgKuty6CzwmcpSQ7bo1/0JxH0rRFWHgKuty6CzwmcpSQ7bo1_1730350296623.jpg から
      // user_images/0JxH0rRFWHgKuty6CzwmcpSQ7bo1/0JxH0rRFWHgKuty6CzwmcpSQ7bo1_1730350296623.jpg を抽出
      final match = RegExp(r'o\/(.+?)\?').firstMatch(path);
      if (match != null) {
        final storagePath = match.group(1);
        if (storagePath != null) {
          final ref = FirebaseStorage.instance.ref().child(storagePath);
          await ref.delete();
          debugPrint('古い画像を削除しました: $storagePath');
        }
      }
    } catch (e) {
      // 削除に失敗しても、新しい画像のアップロードには影響させない
      debugPrint('古い画像の削除に失敗しました: ${e.toString()}');
    }
  }

  Future<void> _updateProfile() async {
    if (!_formKey.currentState!.validate()) return;

    bool _isLoading;
    setState(() => _isLoading = true);

    try {
      String? imageUrl;
      if (_imageFile != null) {
        imageUrl = await _uploadImageToFirebase(_imageFile!);
        if (imageUrl == null) return;

        if (_currentImageUrl != null && _currentImageUrl!.isNotEmpty) {
          await _deleteOldImage(_currentImageUrl!);
        }
      }

      final userId = ref.read(userProvider)?.id;
      if (userId == null) return;

      final result = await GraphQLProvider.of(context).value.mutate(
            MutationOptions(
              document: gql('''
            mutation UpdateUserData(
              \$id: String!
              \$name: String
              \$imageUrl: String
              \$evmAddr: String
              \$greeting: String
              \$skill: String
              \$xHandle: String
              \$instagramHandle: String
              \$fbHandle: String
            ) {
              updateUserData(input: {
                id: \$id
                name: \$name
                imageUrl: \$imageUrl
                evmAddr: \$evmAddr
                greeting: \$greeting
                skill: \$skill
                xHandle: \$xHandle
                instagramHandle: \$instagramHandle
                fbHandle: \$fbHandle
              }) {
                userInfo {
                  id
                  name
                  imageUrl
                  evmAddr
                  role
                  primaryRole
                  greeting
                  skill
                  xHandle
                  instagramHandle
                  fbHandle
                  interestOffer
                  createdAt
                  belongsToArtists {
                    id
                    artistId
                    name
                    imageUrl
                    fsp
                    status
                    isAdmin
                  }
                  primaryArtist {
                    id
                    artistId
                    name
                    imageUrl
                    fsp
                    status
                    isAdmin
                  }
                }
              }
            }
          '''),
              variables: {
                'id': userId,
                'name': _nameController.text,
                'imageUrl': imageUrl ?? _currentImageUrl,
                'evmAddr': _evmAddrController.text,
                'greeting': _greetingController.text,
                'skill': _skillController.text,
                'xHandle': _xHandleController.text,
                'instagramHandle': _instagramHandleController.text,
                'fbHandle': _fbHandleController.text,
              },
              fetchPolicy: FetchPolicy.noCache,
            ),
          );

      print('result: $result');

      if (result.hasException) {
        throw result.exception!;
      }

      // 更新が成功したら、プロバイダーのimageUrlを更新
      final newImageUrl = imageUrl ?? _currentImageUrl;
      ref.read(userProvider.notifier).updateImageUrl(newImageUrl);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('プロフィールを更新しました'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('プロフィールの更新に失敗しました: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 現在のフォーカスを解除してキーボードを閉じる
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('プロフィール編集'),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: _imageFile != null
                          ? FileImage(_imageFile!) as ImageProvider
                          : (_currentImageUrl != null
                                  ? NetworkImage(_currentImageUrl!)
                                  : const AssetImage(
                                      'assets/default_avatar.png'))
                              as ImageProvider,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon:
                              const Icon(Icons.camera_alt, color: Colors.white),
                          onPressed: _pickImage,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: '名前',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '名前を入力してください';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _greetingController,
                decoration: const InputDecoration(
                  labelText: '自己紹介',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _skillController,
                decoration: const InputDecoration(
                  labelText: 'スキル',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              // SNSハンドル入力フィールド
              TextFormField(
                controller: _xHandleController,
                decoration: const InputDecoration(
                  labelText: 'X (Twitter)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _instagramHandleController,
                decoration: const InputDecoration(
                  labelText: 'Instagram',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _fbHandleController,
                decoration: const InputDecoration(
                  labelText: 'Facebook',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _evmAddrController,
                decoration: const InputDecoration(
                  labelText: 'EVMアドレス',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _updateProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  elevation: 1,
                  side: const BorderSide(color: Colors.grey),
                ),
                child: const Text('プロフィールを更新'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _greetingController.dispose();
    _skillController.dispose();
    _xHandleController.dispose();
    _instagramHandleController.dispose();
    _fbHandleController.dispose();
    _evmAddrController.dispose();
    super.dispose();
  }
}
