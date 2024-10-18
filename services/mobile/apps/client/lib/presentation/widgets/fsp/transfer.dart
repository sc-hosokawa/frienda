import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class Transfer extends StatefulWidget {
  const Transfer({super.key});

  @override
  State<Transfer> createState() => _TransferState();
}

class _TransferState extends State<Transfer> {
  final TextEditingController _recipientController = TextEditingController();
  final TextEditingController _pointsController = TextEditingController();
  bool _isLongPressed = true;
  int _availablePoints = 1000; // 仮の初期値

  @override
  void dispose() {
    _recipientController.dispose();
    _pointsController.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    controller.scannedDataStream.listen((scanData) {
      if (scanData.code != null) {
        setState(() {
          _recipientController.text = scanData.code!;
        });
        controller.dispose();
        Navigator.pop(context);
      }
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
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => _showConfirmationDialog(context),
                  child: const Text('送る'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    final int pointsToSend = int.tryParse(_pointsController.text) ?? 0;
    final int remainingPoints = _availablePoints - pointsToSend;

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
            ],
          ),
          actions: <Widget>[
            SizedBox(
              width: double.infinity,
              child: GestureDetector(
                onLongPress: () {
                  // TODO: ポイント送付の処理を追加
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('ポイントを送付しました')),
                  );
                },
                child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return GestureDetector(
                      onLongPressStart: (_) =>
                          setState(() => _isLongPressed = true),
                      onLongPressEnd: (_) =>
                          setState(() => _isLongPressed = false),
                      child: ElevatedButton(
                        onPressed: null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              _isLongPressed ? Colors.lightGreen : Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('送付（長押し）'),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 8), // ボタン間のスペース
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
}

class _AvailablePointsAndQRScanner extends StatelessWidget {
  final VoidCallback onQRScanTap;

  const _AvailablePointsAndQRScanner({required this.onQRScanTap});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('利用可能ポイント', style: textTheme.bodySmall),
            Text('1,000 ポイント', style: textTheme.titleMedium),
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

  const _TransferInputFields({
    required this.recipientController,
    required this.pointsController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: recipientController,
          decoration: const InputDecoration(
            labelText: '受取ユーザーのユーザー名かEmail',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: pointsController,
          decoration: const InputDecoration(
            labelText: '送るポイント数',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }
}
