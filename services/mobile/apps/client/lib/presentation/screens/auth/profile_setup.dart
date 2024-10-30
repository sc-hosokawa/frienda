import 'package:client/presentation/providers/client_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/presentation/screens/main_screen.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:client/presentation/providers/user_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class ProfileSetupScreen extends ConsumerStatefulWidget {
  final User user;
  final Map<String, String> initialData;

  const ProfileSetupScreen({
    super.key,
    required this.user,
    required this.initialData,
  });

  @override
  ConsumerState<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends ConsumerState<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _displayNameController = TextEditingController();
  String? _photoURL;

  String? _selectedCategory;
  String? _selectedPrimaryCategory;
  String? _categoryError;

  // カテゴリーの選択肢
  final List<Map<String, String>> _categories = [
    {'id': 'Musician', 'name': 'ミュージシャン'},
    {'id': 'Curator', 'name': 'キュレーター'},
    {'id': 'Creater', 'name': 'クリエイター'},
    {'id': 'Supporter', 'name': 'サポーター'},
  ];

  // Mutation 文字列を定数として定義
  static const String CREATE_USER_MUTATION = r'''
    mutation CreateNewUserData($input: CreateNewUserDataInput!) {
      createNewUserData(input: $input) {
        userId
        name
        imageUrl
      }
    }
  ''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('プロフィール設定')),
      body: Mutation(
        options: MutationOptions(
          document: gql(CREATE_USER_MUTATION),
          onCompleted: (dynamic resultData) async {
            if (resultData == null) return;

            final userData = resultData['createNewUserData'];
            print('Debug: User data: $userData');

            ref.read(userProvider.notifier).updateUser(
                  UserData(
                    id: widget.initialData['uid'] ?? '',
                    email: widget.initialData['email'] ?? '',
                    name: userData['name'],
                    imageUrl: userData['imageUrl'],
                    fspBalance: 0,
                    credentialBalance: 0,
                    role: _selectedCategory ?? '',
                    primaryRole: _selectedPrimaryCategory ?? '',
                    belongsToArtists: [],
                    primaryArtist: null,
                  ),
                );

            await widget.user.reload();

            if (mounted) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => MainScreen()),
              );
            }
          },
          onError: (error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('プロフィールの更新に失敗しました: ${error.toString()}')),
            );
          },
        ),
        builder: (RunMutation runMutation, QueryResult? result) {
          return Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            _photoURL != null ? NetworkImage(_photoURL!) : null,
                        child: _photoURL == null
                            ? Icon(Icons.person, size: 50)
                            : null,
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: IconButton(
                          onPressed: _selectImage,
                          icon: Icon(Icons.camera_alt),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _displayNameController,
                  decoration: InputDecoration(
                    labelText: 'ユーザーネーム',
                    hintText: 'あなたの表示名を入力してください',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ユーザーネームを入力してください';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                // カテゴリー選択
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  decoration: InputDecoration(
                    labelText: 'カテゴリー',
                    hintText: 'あなたの属性を選択してください',
                    errorText: _categoryError,
                  ),
                  items: _categories.map((category) {
                    return DropdownMenuItem(
                      value: category['id'],
                      child: Text(category['name']!),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value;
                      // カテゴリーが変更されたら、プライマリーカテゴリーと同じ場合はエラーを表示
                      _validateCategories();
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'カテゴリーを選択してください';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 16),

                // プライマリーカテゴリー選択
                DropdownButtonFormField<String>(
                  value: _selectedPrimaryCategory,
                  decoration: InputDecoration(
                    labelText: 'プライマリーカテゴリー',
                    hintText: 'メインとなる属性を選択してください',
                  ),
                  items: _categories
                      .map((category) {
                        // 現在選択されているカテゴリーは選択肢から除外
                        if (category['id'] == _selectedCategory) {
                          return null;
                        }
                        return DropdownMenuItem(
                          value: category['id'],
                          child: Text(category['name']!),
                        );
                      })
                      .whereType<DropdownMenuItem<String>>()
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedPrimaryCategory = value;
                      _validateCategories();
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'プライマリーカテゴリーを選択してください';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 24),
                // 保存ボタンを修正
                result?.isLoading ?? false
                    ? Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate() &&
                              _validateBeforeSave()) {
                            final variables = {
                              'input': {
                                'id': widget.initialData['uid'],
                                'email': widget.initialData['email'],
                                'name': _displayNameController.text,
                                'imageUrl': _photoURL,
                                'category': _selectedCategory,
                                'primaryCategory': _selectedPrimaryCategory,
                              }
                            };

                            runMutation(variables);
                          }
                        },
                        child: Text('プロフィールを保存'),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }

  // カテゴリーのバリデーション
  void _validateCategories() {
    if (_selectedCategory == _selectedPrimaryCategory &&
        _selectedCategory != null &&
        _selectedPrimaryCategory != null) {
      _categoryError = 'カテゴリーとプライマリーカテゴリーは異なる値を選択してください';
    } else {
      _categoryError = null;
    }
  }

  // 保存前の追加バリデーション
  bool _validateBeforeSave() {
    if (_selectedCategory == _selectedPrimaryCategory) {
      setState(() {
        _categoryError = 'カテゴリーとプライマリーカテゴリーは異なる値を選択してください';
      });
      return false;
    }
    return true;
  }

  Future<void> _selectImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (image == null) return;

      if (!mounted) return;

      // Show loading indicator
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('画像をアップロード中...')),
      );

      // Create file reference
      final File imageFile = File(image.path);
      if (!await imageFile.exists()) {
        throw Exception('Selected image file does not exist');
      }

      // Generate a unique filename using timestamp
      final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final String filename = '${widget.user.uid}_$timestamp.jpg';

      // Upload to Firebase Storage with correct path structure
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('user_images')
          .child(widget.user.uid) // ユーザーIDのフォルダを作成
          .child(filename);

      // Upload with metadata
      final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'userId': widget.user.uid},
      );

      await storageRef.putFile(imageFile, metadata);
      final downloadUrl = await storageRef.getDownloadURL();

      setState(() {
        _photoURL = downloadUrl;
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('画像のアップロードが完了しました')),
      );
    } catch (e) {
      print('Image upload error: $e');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('画像のアップロードに失敗しました: ${e.toString()}')),
      );
    }
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    super.dispose();
  }
}
