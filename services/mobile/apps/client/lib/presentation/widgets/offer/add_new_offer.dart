import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/presentation/providers/user_provider.dart';
import 'dart:async'; // TimeoutExceptionのために必要

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

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Riverpodを使用してユーザーIDを取得
        final userId = ref.read(userProvider)?.id;

        if (userId == null) {
          throw Exception('ユーザーIDが取得できません');
        }

        final GraphQLClient client = GraphQLProvider.of(context).value;

        final MutationOptions options = MutationOptions(
          document: gql('''
            mutation CreateNewOffer(
              \$title: String!
              \$description: String!
              \$fee: Int!
              \$deadline: String!
              \$place: String!
              \$category: String
              \$attention: String
              \$requiredSkill: String
              \$targetRole: String
              \$publicity: Boolean
              \$owner: String!
            ) {
              createNewOffer(input: {
                title: \$title
                description: \$description
                fee: \$fee
                deadline: \$deadline
                place: \$place
                category: \$category
                attention: \$attention
                requiredSkill: \$requiredSkill
                targetRole: \$targetRole
                publicity: \$publicity
                owner: \$owner
              }) {
                id
              }
            }
          '''),
          variables: {
            'title': _titleController.text,
            'description': _descriptionController.text,
            'fee': int.parse(_feeController.text),
            'deadline': _deadlineController.text,
            'place': _placeController.text,
            'category': _categoryController.text.isEmpty
                ? null
                : _categoryController.text,
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
            'owner': userId,
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
      } on TimeoutException catch (e) {
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
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
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
                      decoration: const InputDecoration(
                        labelText: 'タイトル',
                        border: OutlineInputBorder(),
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
                      decoration: const InputDecoration(
                        labelText: '説明',
                        border: OutlineInputBorder(),
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
                      decoration: const InputDecoration(
                        labelText: '報酬 (FSP)',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '報酬を入力してください';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _deadlineController,
                      decoration: const InputDecoration(
                        labelText: '締切日',
                        border: OutlineInputBorder(),
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
                      decoration: const InputDecoration(
                        labelText: '場所',
                        border: OutlineInputBorder(),
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
                      decoration: const InputDecoration(
                        labelText: 'カテゴリー',
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(
                            value: 'Creation', child: Text('Creation')),
                        DropdownMenuItem(value: 'Event', child: Text('Event')),
                        DropdownMenuItem(
                            value: 'Promotion', child: Text('Promotion')),
                        DropdownMenuItem(value: 'Other', child: Text('Other')),
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
                      decoration: const InputDecoration(
                        labelText: '注意事項',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _requiredSkillController,
                      decoration: const InputDecoration(
                        labelText: '必要なスキル',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: _targetRoleController.text.isEmpty
                          ? null
                          : _targetRoleController.text,
                      decoration: const InputDecoration(
                        labelText: '対象ユーザー',
                        border: OutlineInputBorder(),
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
                      child: const Text('投稿する'),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
