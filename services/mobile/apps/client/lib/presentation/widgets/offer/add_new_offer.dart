import 'package:flutter/material.dart';

class AddNewOffer extends StatefulWidget {
  const AddNewOffer({super.key});

  @override
  _AddNewOfferState createState() => _AddNewOfferState();
}

class _AddNewOfferState extends State<AddNewOffer> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement offer submission logic
      print('Offer submitted: ${_titleController.text}');

      // Clear the form
      _titleController.clear();
      _descriptionController.clear();

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('投稿が完了しました')),
      );

      // Return to the Offer page
      Navigator.of(context)
          .pop(true); // Pass true to indicate successful submission
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        children: [
          AppBar(
            title: const Text('新規Offer追加'),
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
