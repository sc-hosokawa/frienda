import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class MessageRoom extends StatefulWidget {
  const MessageRoom({super.key});

  @override
  State<MessageRoom> createState() => _MessageRoomState();
}

class _MessageRoomState extends State<MessageRoom> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        children: [
          SafeArea(
            child: AppBar(
              title: const Text('メッセージ'),
              titleTextStyle: Theme.of(context).textTheme.titleMedium,
              centerTitle: true,
            ),
          ),
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: 10,
              itemBuilder: (context, index) {
                final isMyMessage = index % 2 == 0;
                return MessageBubble(
                  message: _getLongMessage(9 - index),
                  isMyMessage: isMyMessage,
                  timestamp: DateTime.now()
                      .subtract(Duration(minutes: (9 - index) * 5)),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, -1),
                ),
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _attachFile,
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'メッセージを入力...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      filled: true,
                      fillColor: Theme.of(context).cardColor,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _attachFile() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo),
                title: Text('写真'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage();
                },
              ),
              ListTile(
                leading: Icon(Icons.file_present),
                title: Text('ファイル'),
                onTap: () {
                  Navigator.pop(context);
                  _pickFile();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        print('Selected image: ${image.path}');
        await _uploadImageToCloudStorage(image);
      } else {
        print('No image selected');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> _uploadImageToCloudStorage(XFile image) async {
    try {
      File imageFile = File(image.path);
      FirebaseStorage storage = FirebaseStorage.instance;
      String fileName = 'images/${DateTime.now().millisecondsSinceEpoch}.jpg';
      Reference ref = storage.ref().child(fileName);

      UploadTask uploadTask = ref.putFile(imageFile);

      await uploadTask.whenComplete(() => print('Image uploaded'));

      // アップロードされた画像のURLを取得
      String downloadURL = await ref.getDownloadURL();
      print('Image available at: $downloadURL');

      // TODO: ここでダウンロードURLをメッセージに添付するなどの処理を行う
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  void _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: true,
      );

      if (result != null) {
        List<PlatformFile> files = result.files;
        for (var file in files) {
          print('Selected file: ${file.name}, Size: ${file.size} bytes');
          await _uploadFileToCloudStorage(file);
        }
      } else {
        print('No file selected');
      }
    } catch (e) {
      print('Error picking file: $e');
    }
  }

  Future<void> _uploadFileToCloudStorage(PlatformFile file) async {
    try {
      File fileToUpload = File(file.path!);
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child('uploads/${file.name}');

      UploadTask uploadTask = ref.putFile(fileToUpload);

      await uploadTask.whenComplete(() => print('File uploaded'));

      // アップロードされたファイルのURLを取得
      String downloadURL = await ref.getDownloadURL();
      print('File available at: $downloadURL');

      // TODO: ここでダウンロードURLをメッセージに添付するなどの処理を行う
    } catch (e) {
      print('Error uploading file: $e');
    }
  }

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      // TODO: Implement message sending logic
      print('送信されたメッセージ: ${_messageController.text}');
      _messageController.clear();
    }
  }

  String _getLongMessage(int index) {
    List<String> messages = [
      'こんにちは！今日はとても良い天気ですね。外を散歩するのにぴったりの日和です。',
      'そうですね。私も先ほど少し外に出てきました。春の陽気を感じられて気分が良いです。',
      '週末に友達と公園でピクニックをする予定なんです。お弁当を作ろうと思っているのですが、何かおすすめのレシピはありますか？',
      'いいですね！春のピクニックは最高です。簡単でおいしいサンドイッチはいかがでしょうか？野菜たっぷりで健康的ですよ。',
      'サンドイッチ、いいアイデアですね。具材に何を入れるか考えるのが楽しみです。デザートも何か作ろうかな。',
      'フルーツサラダはどうでしょう？季節のフルーツを使えば、さわやかで見た目も綺麗ですよ。',
      '素敵なアイデアをありがとうございます。きっと楽しいピクニックになりそうです。あなたも機会があればぜひ春のピクニックを楽しんでくださいね。',
      'ありがとうございます。私も近々友人たちと計画を立てようと思います。楽しい時間を過ごせますように！',
      'そうそう、ピクニックの後で近くの美術館に行く予定もあるんです。最近、新しい展示が始まったらしくて。',
      '美術館もいいですね。芸術に触れると心が豊かになりますよ。素敵な1日になりそうです。楽しんできてくださいね。',
    ];
    return messages[index % messages.length];
  }
}

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMyMessage;
  final DateTime timestamp;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isMyMessage,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMyMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        width: MediaQuery.of(context).size.width * 2 / 3,
        child: Column(
          crossAxisAlignment:
              isMyMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isMyMessage ? Colors.green[300] : Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                message,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 4),
            Text(
              DateFormat('yyyy/MM/dd HH:mm').format(timestamp),
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
