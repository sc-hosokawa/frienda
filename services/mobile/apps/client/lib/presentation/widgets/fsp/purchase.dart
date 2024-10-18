import 'package:flutter/material.dart';

class Purchase extends StatelessWidget {
  const Purchase({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SafeArea(
          child: AppBar(
            title: const Text('FSPポイント購入'),
            titleTextStyle: Theme.of(context).textTheme.titleMedium,
            centerTitle: true,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: '購入ポイント数',
                      hintText: '1000',
                      suffixText: 'FSP',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'クレジットカード番号',
                      hintText: '1234 5678 9012 3456',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: '有効期限',
                            hintText: 'MM/YY',
                          ),
                          keyboardType: TextInputType.datetime,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'セキュリティコード',
                            hintText: '123',
                          ),
                          keyboardType: TextInputType.number,
                          obscureText: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: 購入処理を実装
                      },
                      child: const Text('購入する'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
