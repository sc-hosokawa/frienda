import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/presentation/providers/client_provider.dart';
import 'package:client/presentation/providers/user_provider.dart';

class CreditFormData {
  String role;
  String name;
  String email;

  CreditFormData({
    this.role = '',
    this.name = '',
    this.email = '',
  });
}

class CreditDialog extends ConsumerStatefulWidget {
  final String isrc;
  final String trackName;
  final String artistId;

  const CreditDialog({
    super.key,
    required this.isrc,
    required this.trackName,
    required this.artistId,
  });

  @override
  ConsumerState<CreditDialog> createState() => _CreditDialogState();
}

class _CreditDialogState extends ConsumerState<CreditDialog> {
  List<CreditFormData> credits = [CreditFormData()];

  @override
  void initState() {
    super.initState();
    _fetchExistingCredits();
  }

  Future<void> _fetchExistingCredits() async {
    final userId = ref.read(userProvider)?.id;
    if (userId == null) return;

    try {
      final result = await ref.read(graphQLClientProvider).query(
            QueryOptions(
              document: gql('''
                query GetCredits(\$userId: String!, \$artistId: String!, \$isrc: String!) {
                  getCredits(userId: \$userId, artistId: \$artistId, isrc: \$isrc) {
                    creditRole
                    creditName
                    email
                  }
                }
              '''),
              variables: {
                'userId': userId,
                'artistId': widget.artistId,
                'isrc': widget.isrc,
              },
            ),
          );

      if (!result.hasException && result.data != null) {
        final existingCredits = (result.data!['getCredits'] as List)
            .map((credit) => CreditFormData(
                  role: credit['creditRole'] ?? '',
                  name: credit['creditName'] ?? '',
                  email: credit['email'] ?? '',
                ))
            .toList();

        setState(() {
          credits =
              existingCredits.isEmpty ? [CreditFormData()] : existingCredits;
        });
      }
    } catch (e) {
      print('Error fetching credits: $e');
    }
  }

  void _addCreditForm() {
    setState(() {
      credits.add(CreditFormData());
    });
  }

  void _removeCreditForm(int index) {
    if (credits.length > 1) {
      setState(() {
        credits.removeAt(index);
      });
    }
  }

  Future<void> _handleSubmit() async {
    final userId = ref.read(userProvider)?.id;
    if (userId == null) return;

    try {
      final result = await ref.read(graphQLClientProvider).mutate(
            MutationOptions(
              document: gql('''
                mutation RegisterCredit(\$input: RegisterCreditInput!) {
                  registerCredit(input: \$input) {
                    isSuccess
                  }
                }
              '''),
              variables: {
                'input': {
                  'registerInfo': credits
                      .map((credit) => {
                            'isrc': widget.isrc,
                            'commitUser': userId,
                            'creditRole': credit.role,
                            'creditName': credit.name,
                            'email': credit.email,
                            'isInvite': true,
                            'memo': '',
                          })
                      .toList(),
                },
              },
            ),
          );

      if (!result.hasException) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      print('Error registering credits: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('クレジットの登録に失敗しました')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        '${widget.trackName}のクレジット編集',
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...credits.asMap().entries.map((entry) {
              final index = entry.key;
              final credit = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          TextField(
                            decoration: const InputDecoration(labelText: 'ロール'),
                            controller:
                                TextEditingController(text: credit.role),
                            onChanged: (value) =>
                                setState(() => credit.role = value),
                          ),
                          TextField(
                            decoration: const InputDecoration(labelText: '名前'),
                            controller:
                                TextEditingController(text: credit.name),
                            onChanged: (value) =>
                                setState(() => credit.name = value),
                          ),
                          TextField(
                            decoration:
                                const InputDecoration(labelText: 'Email'),
                            controller:
                                TextEditingController(text: credit.email),
                            onChanged: (value) =>
                                setState(() => credit.email = value),
                          ),
                        ],
                      ),
                    ),
                    if (index > 0)
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: () => _removeCreditForm(index),
                      ),
                  ],
                ),
              );
            }).toList(),
            TextButton.icon(
              onPressed: _addCreditForm,
              icon: const Icon(Icons.add_circle_outline),
              label: const Text('フォームを追加'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('キャンセル'),
        ),
        ElevatedButton(
          onPressed: _handleSubmit,
          child: const Text('登録'),
        ),
      ],
    );
  }
}
