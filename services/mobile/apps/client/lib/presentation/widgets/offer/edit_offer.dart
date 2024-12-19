import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:client/presentation/providers/client_provider.dart';
import 'package:client/presentation/providers/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditOfferPage extends ConsumerStatefulWidget {
  final int offerId;

  const EditOfferPage({
    super.key,
    required this.offerId,
  });

  @override
  ConsumerState<EditOfferPage> createState() => _EditOfferPageState();
}

class _EditOfferPageState extends ConsumerState<EditOfferPage> {
  final _formKey = GlobalKey<FormState>();
  File? _selectedImage;
  String? _imagePreviewUrl;
  bool _isPublic = true;
  bool _isLoading = false;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _feeController = TextEditingController();
  final TextEditingController _attentionController = TextEditingController();
  final TextEditingController _requiredSkillController =
      TextEditingController();

  String _selectedCategory = '';
  String _selectedTargetRole = '';

  final List<String> _categories = ['Creation', 'Event', 'Promotion', 'Other'];
  final List<String> _targetRoles = [
    'Musician',
    'Curator',
    'Creator',
    'Supporter',
  ];

  static const String getOfferQuery = '''
    query GetOfferById(\$offerId: Int!, \$userId: String!) {
      getOffersById(offerId: \$offerId, userId: \$userId) {
        id
        title
        description
        imageUrl
        fee
        category
        place
        attention
        requiredSkill
        targetRole
        publicity
        attachedImgs
        attachedFiles
      }
    }
  ''';

  static const String updateOfferMutation = '''
    mutation UpdateOffer(\$input: UpdateOfferInput!) {
      updateOfferInfo(input: \$input) {
        id
      }
    }
  ''';

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchOfferData();
  }

  Future<void> _fetchOfferData() async {
    final user = ref.read(userProvider);
    setState(() => _isLoading = true);

    try {
      final QueryResult result = await GraphQLProvider.of(context).value.query(
            QueryOptions(
              document: gql(getOfferQuery),
              variables: {
                'offerId': widget.offerId,
                'userId': user?.id ?? '',
              },
              fetchPolicy: FetchPolicy.networkOnly,
            ),
          );

      if (result.hasException) {
        throw result.exception!;
      }

      final offer = result.data?['getOffersById'];
      if (offer != null) {
        setState(() {
          _titleController.text = offer['title'] ?? '';
          _descriptionController.text = offer['description'] ?? '';
          _placeController.text = offer['place'] ?? '';
          _feeController.text = offer['fee']?.toString() ?? '';
          _selectedCategory = offer['category'] ?? '';
          _selectedTargetRole = offer['targetRole'] ?? '';
          _isPublic = offer['publicity'] ?? true;
          _imagePreviewUrl = offer['imageUrl'];
          _attentionController.text = offer['attention'] ?? '';
          _requiredSkillController.text = offer['requiredSkill'] ?? '';
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching offer data: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final MutationOptions options = MutationOptions(
        document: gql(updateOfferMutation),
        variables: {
          'input': {
            'id': widget.offerId,
            'title': _titleController.text.trim(),
            'description': _descriptionController.text.trim(),
            'fee': int.tryParse(_feeController.text.trim()) ?? 0,
            'category': _selectedCategory,
            'place': _placeController.text.trim(),
            'targetRole': _selectedTargetRole,
            'publicity': _isPublic,
            'attention': _attentionController.text.trim(),
            'requiredSkill': _requiredSkillController.text.trim(),
          },
        },
        onError: (error) {
          print('GraphQL Error: ${error.toString()}');
        },
      );

      final QueryResult result =
          await GraphQLProvider.of(context).value.mutate(options);

      if (result.hasException) {
        print('GraphQL Exception: ${result.exception.toString()}');
        throw result.exception!;
      }

      Navigator.pop(context, true);
    } catch (e) {
      print('Error details: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('オファーの更新に失敗しました。もう一度お試しください。')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Offer'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // カテゴリー選択
            Text('カテゴリー', style: Theme.of(context).textTheme.titleMedium),
            Wrap(
              spacing: 8.0,
              children: _categories.map((category) {
                return ChoiceChip(
                  label: Text(category),
                  selected: _selectedCategory == category,
                  onSelected: (selected) {
                    setState(
                        () => _selectedCategory = selected ? category : '');
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 16),

            // オファー名
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'オファー名',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) return 'オファー名を入力してください';
                return null;
              },
            ),

            const SizedBox(height: 16),

            // 説明
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: '説明',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              validator: (value) {
                if (value?.isEmpty ?? true) return '説明を入力してください';
                return null;
              },
            ),

            const SizedBox(height: 16),

            // 料金
            TextFormField(
              controller: _feeController,
              decoration: const InputDecoration(
                labelText: 'Fee',
                border: OutlineInputBorder(),
                suffixText: 'FSP',
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value?.isEmpty ?? true) return 'Feeを入力してください';
                if (int.tryParse(value!) == null) return '数値を入力してください';
                return null;
              },
            ),

            const SizedBox(height: 16),

            // 場所
            TextFormField(
              controller: _placeController,
              decoration: const InputDecoration(
                labelText: '場所',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) return '場所を入力してください';
                return null;
              },
            ),

            const SizedBox(height: 16),

            // ターゲットロール選択
            Text('対象ロール', style: Theme.of(context).textTheme.titleMedium),
            Wrap(
              spacing: 8.0,
              children: _targetRoles.map((role) {
                return ChoiceChip(
                  label: Text(role),
                  selected: _selectedTargetRole == role,
                  onSelected: (selected) {
                    setState(() => _selectedTargetRole = selected ? role : '');
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 16),

            // 注意事項
            TextFormField(
              controller: _attentionController,
              decoration: const InputDecoration(
                labelText: '注意事項',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              validator: (value) {
                if (value?.isEmpty ?? true) return '注意事項を入力してください';
                return null;
              },
            ),

            const SizedBox(height: 16),

            // 必要なスキル
            TextFormField(
              controller: _requiredSkillController,
              decoration: const InputDecoration(
                labelText: '必要なスキル',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
              validator: (value) {
                if (value?.isEmpty ?? true) return '必要なスキルを入力してください';
                return null;
              },
            ),

            const SizedBox(height: 16),

            // 画像選択
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: _selectedImage != null
                    ? Image.file(_selectedImage!, fit: BoxFit.cover)
                    : _imagePreviewUrl != null
                        ? Image.network(_imagePreviewUrl!, fit: BoxFit.cover)
                        : const Center(child: Text('タップして画像を選択')),
              ),
            ),

            // 公開設定
            SwitchListTile(
              title: const Text('公開設定'),
              value: _isPublic,
              onChanged: (bool value) {
                setState(() => _isPublic = value);
              },
            ),

            const SizedBox(height: 32),

            // 送信ボタン
            ElevatedButton(
              onPressed: _isLoading ? null : _handleSubmit,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('更新する'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _placeController.dispose();
    _feeController.dispose();
    _attentionController.dispose();
    _requiredSkillController.dispose();
    super.dispose();
  }
}
