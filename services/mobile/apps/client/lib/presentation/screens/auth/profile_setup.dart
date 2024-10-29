import 'package:client/presentation/providers/client_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/presentation/screens/main_screen.dart';
import 'package:ferry/ferry.dart';
import 'package:client/data/graphql/__generated__/schema.schema.gql.dart';
import 'package:client/data/graphql/mutation/__generated__/mutation.req.gql.dart';
import 'package:client/data/graphql/mutation/__generated__/mutation.var.gql.dart';
import 'package:client/data/graphql/mutation/__generated__/mutation.data.gql.dart';
import 'package:client/presentation/providers/user_provider.dart';
// import 'package:image_picker/image_picker.dart';

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
  bool _isLoading = false;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('プロフィール設定')),
      body: Form(
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
                    child:
                        _photoURL == null ? Icon(Icons.person, size: 50) : null,
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
            // 保存ボタン
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: _saveProfile,
                    child: Text('プロフィールを保存'),
                  ),
          ],
        ),
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
    // 画像選択の実装
    // ImagePicker等を使用して画像を選択し、
    // Firebase Storageにアップロードして_photoURLを更新
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate() && _validateBeforeSave()) {
      setState(() => _isLoading = true);
      try {
        // Firebase Authのプロフィール更新
        await widget.user.updateProfile(
          displayName: _displayNameController.text,
          photoURL: _photoURL,
        );

        final client = ref.read(clientProvider);
        final createNewUserMutation = GCreateNewUserDataReq((b) => b
          ..vars = GCreateNewUserDataVars((b) => b
                ..input = GCreateNewUserDataInput((b) => b
                  ..id = widget.initialData['uid']
                  ..email = widget.initialData['email']
                  ..name = _displayNameController.text
                  ..imageUrl = _photoURL
                  ..category = _selectedCategory
                  ..primaryCategory = _selectedPrimaryCategory).toBuilder())
              .toBuilder()
          ..fetchPolicy = FetchPolicy.NetworkOnly);

        try {
          final response = await client!.request(createNewUserMutation).first;
          print('Mutation variables: ${createNewUserMutation.vars.toJson()}');
          print(
              'Operation Name: ${createNewUserMutation.operation.operationName}');
          print(
              'Operation Document: ${createNewUserMutation.operation.document}');
          if (response.hasErrors) {
            throw Exception(response.graphqlErrors!);
          }
          final userData = response.data?.createNewUserData;
          if (userData == null) {
            throw Exception('ユーザー情報の更新に失敗しました');
          }
          ref.read(userProvider.notifier).updateUser(
                id: widget.initialData['uid'],
                email: widget.initialData['email'],
                name: userData.name,
                imageUrl: userData.imageUrl,
                category: _selectedCategory,
                primaryCategory: _selectedPrimaryCategory,
              );
        } catch (e) {
          print(e);
        }

        await widget.user.reload();

        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => MainScreen()),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('プロフィールの更新に失敗しました: ${e.toString()}')),
        );
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    super.dispose();
  }
}
