import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/presentation/providers/user_provider.dart';

class Receive extends ConsumerStatefulWidget {
  const Receive({super.key});

  @override
  ConsumerState<Receive> createState() => _ReceiveState();
}

class _ReceiveState extends ConsumerState<Receive> {
  final TextEditingController _pointsController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  String _qrData = '';

  String _generateQRData() {
    final user = ref.read(userProvider);
    final data = {
      'username': user?.name ?? '',
      'email': user?.email ?? '',
      'points': _pointsController.text,
      'notes': _notesController.text,
    };
    return jsonEncode(data);
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);

    return Column(
      children: [
        SafeArea(
          child: AppBar(
            title: const Text('受取'),
            titleTextStyle: Theme.of(context).textTheme.titleMedium,
            centerTitle: true,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildUserInfo('ユーザー名', user?.name ?? ''),
                _buildUserInfo('メールアドレス', user?.email ?? ''),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _pointsController,
                        decoration: const InputDecoration(
                          labelText: '請求ポイント',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: const Icon(Icons.qr_code),
                      onPressed: () {
                        // キーボードを閉じる
                        FocusScope.of(context).unfocus();
                        setState(() {
                          _qrData = _generateQRData();
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _notesController,
                  decoration: const InputDecoration(
                    labelText: 'メモ',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                if (_qrData.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  Center(
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(10),
                      child: QrImageView(
                        data: _qrData,
                        version: QrVersions.auto,
                        size: 200.0,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUserInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
          IconButton(
            icon: const Icon(Icons.copy),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: value));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('$labelをコピーしました')),
              );
            },
          ),
        ],
      ),
    );
  }
}
