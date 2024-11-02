import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql/client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:client/presentation/providers/user_provider.dart';
import 'package:client/presentation/providers/client_provider.dart';

class Transfer extends ConsumerStatefulWidget {
  const Transfer({super.key});

  @override
  ConsumerState<Transfer> createState() => _TransferState();
}

class _TransferState extends ConsumerState<Transfer> {
  final TextEditingController _recipientController = TextEditingController();
  final TextEditingController _pointsController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  // フォームのキーを追加
  final _formKey = GlobalKey<FormState>();

  Future<void> _executeFspTransfer(String recipientId, int amount) async {
    try {
      final currentUser = ref.read(userProvider);

      final result = await ref.read(graphQLClientProvider).mutate(
            MutationOptions(
              document: gql('''
            mutation CreateFspTx(\$input: CreateNewTransactionInput!) {
              createFspTx(input: \$input) {
                txId
              }
            }
          '''),
              variables: {
                'input': {
                  'from': currentUser?.id,
                  'to': recipientId,
                  'amount': amount,
                  'note': _noteController.text,
                },
              },
            ),
          );

      if (result.hasException) {
        throw Exception(result.exception.toString());
      }
    } catch (e) {
      // エラーハンドリング
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('送金に失敗しました: ${e.toString()}')),
      );
    }
  }

  @override
  void dispose() {
    _recipientController.dispose();
    _pointsController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    controller.scannedDataStream.listen((scanData) {
      try {
        final decodedData = jsonDecode(scanData.code ?? '');
        setState(() {
          _recipientController.text = decodedData['email']?.toString() ?? '';
          _pointsController.text = decodedData['points']?.toString() ?? '';
          _noteController.text = decodedData['note']?.toString() ?? '';
        });
      } catch (e) {
        print('Invalid QR code data: $e');
      }
      controller.dispose();
      Navigator.pop(context);
    });
  }

  void _startQRScanner() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: const Text('受取人のQRコードをスキャン')),
          body: QRView(
            key: GlobalKey(debugLabel: 'QR'),
            onQRViewCreated: _onQRViewCreated,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SafeArea(
          child: AppBar(
            title: const Text('送る'),
            titleTextStyle: Theme.of(context).textTheme.titleMedium,
            centerTitle: true,
          ),
        ),
        Expanded(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 24),
                  _AvailablePointsAndQRScanner(onQRScanTap: _startQRScanner),
                  const SizedBox(height: 24),
                  _TransferInputFields(
                    recipientController: _recipientController,
                    pointsController: _pointsController,
                    noteController: _noteController,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => _validateAndShowConfirmation(context),
                    child: const Text('送る'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _validateAndShowConfirmation(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _showConfirmationDialog(context);
    }
  }

  void _showConfirmationDialog(BuildContext context) {
    final userInfo = ref.read(userProvider);
    final int pointsToSend = int.tryParse(_pointsController.text) ?? 0;
    final int remainingPoints = (userInfo?.fspBalance ?? 0) - pointsToSend;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
            child: Text('送付内容確認'),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('送付先ユーザー: ${_recipientController.text}'),
              Text('送付するポイント: $pointsToSend'),
              Text('送付後のポイント残高: $remainingPoints'),
              if (_noteController.text.isNotEmpty)
                Text('メモ: ${_noteController.text}'),
            ],
          ),
          actions: <Widget>[
            SizedBox(
              width: double.infinity,
              child: LongPressDraggable<String>(
                data: 'transfer',
                delay: const Duration(seconds: 1),
                onDragStarted: () async {
                  // 送金処理を実行
                  await _executeFspTransfer(
                    _recipientController.text,
                    int.parse(_pointsController.text),
                  );
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('ポイントを送付しました')),
                  );
                  _clearForm();
                },
                feedback: Container(),
                child: ElevatedButton(
                  onPressed: () {}, // 通常のタップでは何も起こらない
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: const Text('送付（1秒間長押し）'),
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                child: const Text('キャンセル'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        );
      },
    );
  }

  void _clearForm() {
    setState(() {
      _recipientController.clear();
      _pointsController.clear();
      _noteController.clear();
    });
  }
}

class _AvailablePointsAndQRScanner extends ConsumerWidget {
  final VoidCallback onQRScanTap;

  const _AvailablePointsAndQRScanner({required this.onQRScanTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final userInfo = ref.watch(userProvider);
    final availablePoints = userInfo?.fspBalance ?? 0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('利用可能ポイント', style: textTheme.bodySmall),
            Text('$availablePoints ポイント', style: textTheme.titleMedium),
          ],
        ),
        ElevatedButton(
          onPressed: onQRScanTap,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(16),
          ),
          child: const Icon(Icons.qr_code_scanner),
        ),
      ],
    );
  }
}

class _TransferInputFields extends StatelessWidget {
  final TextEditingController recipientController;
  final TextEditingController pointsController;
  final TextEditingController noteController;

  const _TransferInputFields({
    required this.recipientController,
    required this.pointsController,
    required this.noteController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: recipientController,
          decoration: const InputDecoration(
            labelText: '受取ユーザーのEmail',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '受取ユーザーを入力してください';
            }
            // Email形式の検証を追加
            final emailRegExp =
                RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
            if (!emailRegExp.hasMatch(value)) {
              return '有効なメールアドレスを入力してください';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: pointsController,
          decoration: const InputDecoration(
            labelText: '送るポイント数',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'ポイント数を入力してください';
            }
            if (int.tryParse(value) == null) {
              return '有効な数字を入力してください';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: noteController,
          decoration: const InputDecoration(
            labelText: 'メモ（任意）',
            border: OutlineInputBorder(),
          ),
          maxLines: 2,
        ),
      ],
    );
  }
}
