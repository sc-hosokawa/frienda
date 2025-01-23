import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/presentation/providers/user_provider.dart';
import 'dart:async'; // TimeoutExceptionのために必要
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';

class AddNewOffer extends ConsumerStatefulWidget {
  const AddNewOffer({super.key});

  @override
  ConsumerState<AddNewOffer> createState() => _AddNewOfferState();
}

class _AddNewOfferState extends ConsumerState<AddNewOffer> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _feeController = TextEditingController();
  final _deadlineController = TextEditingController();
  final _placeController = TextEditingController();
  final _categoryController = TextEditingController();
  final _attentionController = TextEditingController();
  final _requiredSkillController = TextEditingController();
  final _targetRoleController = TextEditingController();
  bool _isPublic = true;
  File? _selectedImage;
  final _picker = ImagePicker();
  final _storage = FirebaseStorage.instance;
  bool _isUploading = false;
  List<PlatformFile> _selectedFiles = [];

  // 共通のInputDecorationを定義
  final _inputDecoration = InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0), // 角の丸みを設定
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
      borderSide: BorderSide(color: Colors.grey),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
      borderSide: BorderSide(color: Colors.white),
    ),
  );

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _feeController.dispose();
    _deadlineController.dispose();
    _placeController.dispose();
    _categoryController.dispose();
    _attentionController.dispose();
    _requiredSkillController.dispose();
    _targetRoleController.dispose();
    super.dispose();
  }

  Future<String?> _uploadImage() async {
    if (_selectedImage == null) return null;

    try {
      // Generate a unique filename
      final fileName =
          'offers/imgs/${DateTime.now().millisecondsSinceEpoch}_${_titleController.text}';
      final ref = _storage.ref().child(fileName);

      // Upload the file
      final uploadTask = ref.putFile(_selectedImage!);

      // Wait for the upload to complete and get the download URL
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      rethrow;
    }
  }

  Future<List<String>> _uploadFiles() async {
    if (_selectedFiles.isEmpty) return [];

    try {
      List<String> fileUrls = [];
      for (var file in _selectedFiles) {
        final fileName =
            'offers/files/${DateTime.now().millisecondsSinceEpoch}_${file.name}';
        final ref = _storage.ref().child(fileName);

        final uploadTask = ref.putFile(File(file.path!));
        final snapshot = await uploadTask;
        final downloadUrl = await snapshot.ref.getDownloadURL();
        fileUrls.add(downloadUrl);
      }
      return fileUrls;
    } catch (e) {
      print('Error uploading files: $e');
      rethrow;
    }
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickFiles() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        // 既存のドキュメント形式
        'pdf', 'doc', 'docx', 'txt',
        // 音楽ファイル
        'mp3', 'wav', 'm4a', 'aac', 'ogg', 'flac',
        // 動画ファイル
        'mp4', 'mov', 'avi', 'wmv', 'flv', 'mkv', 'webm',
      ],
      allowMultiple: true,
    );

    if (result != null) {
      setState(() {
        _selectedFiles = [..._selectedFiles, ...result.files];
      });
    }
  }

  Future<void> _submitForm() async {
    final user = ref.watch(userProvider);
    final userBalance = user?.fspBalance ?? 0;

    // バリデーションを実行
    if (!_formKey.currentState!.validate()) {
      // バリデーション失敗時は処理を中止し、エラーメッセージを表示
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('入力内容を確認してください'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // 報酬額の最終チェック
    final feeValue = int.tryParse(_feeController.text);
    if (feeValue == null || feeValue <= 0 || feeValue > userBalance) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('報酬額が不正です'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isUploading = true;
    });

    try {
      final userId = ref.read(userProvider)?.id;
      if (userId == null) {
        throw Exception('ユーザーIDが取得できません');
      }

      print('userId: $userId');

      // Upload image first if selected
      String? imageUrl;
      if (_selectedImage != null) {
        imageUrl = await _uploadImage();
      }

      List<String> fileUrls = [];
      if (_selectedFiles.isNotEmpty) {
        fileUrls = await _uploadFiles();
      }

      final GraphQLClient client = GraphQLProvider.of(context).value;

      final MutationOptions options = MutationOptions(
        document: gql('''
          mutation CreateNewOffer(
            \$owner: String!
            \$deadline: String
            \$title: String!
            \$description: String!
            \$fee: Int!
            \$imageUrl: String
            \$raidId: Int
            \$category: String
            \$place: String!
            \$attention: String
            \$requiredSkill: String
            \$targetRole: String
            \$publicity: Boolean
            \$attachedImgs: [String!]
            \$attachedFiles: [String!]
          ) {
            createNewOffer(input: {
              owner: \$owner
              deadline: \$deadline
              title: \$title
              description: \$description
              fee: \$fee
              imageUrl: \$imageUrl
              raidId: \$raidId
              category: \$category
              place: \$place
              attention: \$attention
              requiredSkill: \$requiredSkill
              targetRole: \$targetRole
              publicity: \$publicity
              attachedImgs: \$attachedImgs
              attachedFiles: \$attachedFiles
            }) {
              id
            }
          }
        '''),
        variables: {
          'owner': userId,
          'deadline': _deadlineController.text.isEmpty
              ? null
              : _deadlineController.text,
          'title': _titleController.text,
          'description': _descriptionController.text,
          'fee': int.parse(_feeController.text),
          'imageUrl': imageUrl,
          'raidId': null, // 必要に応じて設定
          'category': _categoryController.text.isEmpty
              ? null
              : _categoryController.text,
          'place': _placeController.text,
          'attention': _attentionController.text.isEmpty
              ? null
              : _attentionController.text,
          'requiredSkill': _requiredSkillController.text.isEmpty
              ? null
              : _requiredSkillController.text,
          'targetRole': _targetRoleController.text.isEmpty
              ? null
              : _targetRoleController.text,
          'publicity': _isPublic,
          'attachedImgs': imageUrl != null ? [imageUrl] : [],
          'attachedFiles': fileUrls,
        },
        fetchPolicy: FetchPolicy.noCache,
        errorPolicy: ErrorPolicy.all,
      );

      final QueryResult result = await client.mutate(options).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw TimeoutException('リクエストがタイムアウトしました');
        },
      );

      print('GraphQL Response: ${result.data}');

      if (result.hasException) {
        throw Exception(result.exception.toString());
      }

      // Clear the form
      _titleController.clear();
      _descriptionController.clear();
      _feeController.clear();
      _deadlineController.clear();
      _placeController.clear();
      _categoryController.clear();
      _attentionController.clear();
      _requiredSkillController.clear();
      _targetRoleController.clear();

      // Show success message
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('投稿が完了しました')),
      );

      // Return to the previous screen
      Navigator.of(context).pop(true);
    } on TimeoutException {
      // タイムアウトの処理
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('リクエストがタイムアウトしました。もう一度お試しください。'),
          backgroundColor: Colors.orange,
        ),
      );
    } catch (e) {
      // Show error message
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('エラーが発生しました: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // ユーザーの残高を取得
    final user = ref.watch(userProvider);
    final userBalance = user?.fspBalance ?? 0;

    print('userBalance: $userBalance');

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: [
          Column(
            children: [
              AppBar(
                title: const Text(
                  '新規Offer追加',
                  style: TextStyle(
                    fontSize: 16.0, // サイズを小さく設定
                  ),
                ),
              ),
              Expanded(
                child: Form(
                    key: _formKey,
                    child: ListView(
                      padding: const EdgeInsets.all(16.0),
                      children: [
                        TextFormField(
                          controller: _titleController,
                          decoration: _inputDecoration.copyWith(
                            labelText: 'タイトル',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'タイトルを入力してください';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _descriptionController,
                          decoration: _inputDecoration.copyWith(
                            labelText: '説明',
                          ),
                          maxLines: 5,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '説明を入力してください';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _feeController,
                          decoration: _inputDecoration.copyWith(
                            labelText: '報酬 (FSP)',
                            helperText: '現在の残高: $userBalance FSP',
                          ),
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: false,
                            signed: false,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '報酬を入力してください';
                            }

                            // 数値として解析
                            int? fee;
                            try {
                              fee = int.parse(value);
                            } catch (e) {
                              return '有効な数値を入力してください';
                            }

                            // 0以上の値であることを確認
                            if (fee <= 0) {
                              return '0より大きい値を入力してください';
                            }

                            // 残高以下であることを確認
                            if (fee > userBalance) {
                              return '残高を超える報酬は設定できません';
                            }

                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _deadlineController,
                          decoration: _inputDecoration.copyWith(
                            labelText: '締切日',
                            hintText: '例: 2024/12/31 23:59', // 入力形式のヒントを追加
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '締切日を選択してください';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _placeController,
                          decoration: _inputDecoration.copyWith(
                            labelText: '場所',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '場所を入力してください';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          value: _categoryController.text.isEmpty
                              ? null
                              : _categoryController.text,
                          decoration: _inputDecoration.copyWith(
                            labelText: 'カテゴリー',
                          ),
                          items: const [
                            DropdownMenuItem(
                                value: 'Creation', child: Text('Creation')),
                            DropdownMenuItem(
                                value: 'Event', child: Text('Event')),
                            DropdownMenuItem(
                                value: 'Promotion', child: Text('Promotion')),
                            DropdownMenuItem(
                                value: 'Other', child: Text('Other')),
                          ],
                          onChanged: (value) {
                            if (value != null) {
                              _categoryController.text = value;
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _attentionController,
                          decoration: _inputDecoration.copyWith(
                            labelText: '注意事項',
                          ),
                          maxLines: 3,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _requiredSkillController,
                          decoration: _inputDecoration.copyWith(
                            labelText: '必要なスキル',
                          ),
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          value: _targetRoleController.text.isEmpty
                              ? null
                              : _targetRoleController.text,
                          decoration: _inputDecoration.copyWith(
                            labelText: '対象ユーザー',
                          ),
                          items: const [
                            DropdownMenuItem(
                                value: 'Musician', child: Text('Musician')),
                            DropdownMenuItem(
                                value: 'Creator', child: Text('Creator')),
                            DropdownMenuItem(
                                value: 'Curator', child: Text('Curator')),
                            DropdownMenuItem(
                                value: 'Supporter', child: Text('Supporter')),
                          ],
                          onChanged: (value) {
                            if (value != null) {
                              _targetRoleController.text = value;
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('画像', style: TextStyle(fontSize: 16)),
                            const SizedBox(height: 8),
                            Container(
                              height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: _selectedImage != null
                                  ? Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        Image.file(
                                          _selectedImage!,
                                          fit: BoxFit.cover,
                                        ),
                                        Positioned(
                                          right: 8,
                                          top: 8,
                                          child: IconButton(
                                            icon: const Icon(Icons.close),
                                            onPressed: () {
                                              setState(() {
                                                _selectedImage = null;
                                              });
                                            },
                                            color: Colors.white,
                                            style: IconButton.styleFrom(
                                              backgroundColor: Colors.black54,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : InkWell(
                                      onTap: _pickImage,
                                      child: const Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.add_photo_alternate,
                                              size: 40),
                                          SizedBox(height: 8),
                                          Text('タップして画像を選択'),
                                        ],
                                      ),
                                    ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('添付ファイル',
                                style: TextStyle(fontSize: 16)),
                            const SizedBox(height: 8),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (_selectedFiles.isNotEmpty) ...[
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: _selectedFiles.length,
                                      itemBuilder: (context, index) {
                                        final file = _selectedFiles[index];
                                        return ListTile(
                                          dense: true,
                                          title: Text(file.name),
                                          subtitle: Text(
                                              '${(file.size / 1024).toStringAsFixed(1)} KB'),
                                          trailing: IconButton(
                                            icon: const Icon(Icons.close),
                                            onPressed: () {
                                              setState(() {
                                                _selectedFiles.removeAt(index);
                                              });
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                    const Divider(),
                                  ],
                                  Center(
                                    child: TextButton.icon(
                                      onPressed: _pickFiles,
                                      icon: const Icon(Icons.attach_file),
                                      label: const Text('ファイルを追加'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (_selectedFiles.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  '選択中: ${_selectedFiles.length}個のファイル',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SwitchListTile(
                          title: const Text('公開設定'),
                          value: _isPublic,
                          onChanged: (bool value) {
                            setState(() {
                              _isPublic = value;
                            });
                          },
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: _submitForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                          ),
                          child: const Text('投稿する'),
                        ),
                      ],
                    )),
              ),
            ],
          ),
          if (_isUploading)
            Container(
              color: Colors.black45,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
