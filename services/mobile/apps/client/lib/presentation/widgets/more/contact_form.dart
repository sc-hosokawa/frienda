import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _message = '';
  String _category = 'お問い合わせ';

  final String contactToAdminMutation = '''
    mutation ContactToAdmin(\$input: ContactToAdminInput!) {
      contactToAdmin(input: \$input)
    }
  ''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('お問い合わせ / 不具合報告'),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<String>(
                  value: _category,
                  decoration: const InputDecoration(labelText: 'カテゴリ'),
                  items: ['お問い合わせ', '不具合報告']
                      .map((label) => DropdownMenuItem(
                            value: label,
                            child: Text(label),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _category = value!;
                    });
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'お名前'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'お名前を入力してください';
                    }
                    return null;
                  },
                  onSaved: (value) => _name = value!,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'メールアドレス'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'メールアドレスを入力してください';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return '有効なメールアドレスを入力してください';
                    }
                    return null;
                  },
                  onSaved: (value) => _email = value!,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'メッセージ'),
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'メッセージを入力してください';
                    }
                    return null;
                  },
                  onSaved: (value) => _message = value!,
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                    ),
                    child: const Text('送信'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        final client = GraphQLProvider.of(context).value;

        final result = await client.mutate(
          MutationOptions(
            document: gql(contactToAdminMutation),
            variables: {
              'input': {
                'username': _name,
                'category': _category,
                'email': _email,
                'content': _message,
              },
            },
          ),
        );

        if (result.hasException) {
          throw result.exception!;
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('お問い合わせを送信しました')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('送信に失敗しました: ${e.toString()}')),
        );
      }
    }
  }
}
