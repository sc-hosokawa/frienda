import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/user_provider.dart';
import '../../providers/auth_provider.dart';

class MessageRoom extends ConsumerStatefulWidget {
  const MessageRoom({super.key, required this.roomId});

  final String roomId;

  @override
  ConsumerState<MessageRoom> createState() => _MessageRoomState();
}

class _MessageRoomState extends ConsumerState<MessageRoom> {
  final TextEditingController _messageController = TextEditingController();

  // Refetch型として定義
  Refetch? _refetchMessages;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userId = ref.watch(authProvider).uid;

    return Query(
      options: QueryOptions(
        document: gql('''
          query GetMessages(\$userId: String!, \$messageRoomId: String!) {
            getMessagesByMessageRoomId(userId: \$userId, messageRoomId: \$messageRoomId) {
              messageList {
                id
                content
                sentAt
                sentBy
              }
              to {
                id
                name
                imageUrl
              }
            }
          }
        '''),
        variables: {
          'userId': userId,
          'messageRoomId': widget.roomId,
        },
        pollInterval: const Duration(seconds: 3),
      ),
      builder: (QueryResult result, {Refetch? refetch, FetchMore? fetchMore}) {
        // refetch関数を保存
        _refetchMessages = refetch;

        // ... error and loading handling ...

        final messages =
            result.data?['getMessagesByMessageRoomId']['messageList'] ?? [];
        print('msg list result: $result');

        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: [
              SafeArea(
                child: AppBar(
                  title: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            result.data?['getMessagesByMessageRoomId']['to']
                                        ['imageUrl'] !=
                                    null
                                ? NetworkImage(
                                    result.data!['getMessagesByMessageRoomId']
                                        ['to']['imageUrl'] as String)
                                : null,
                        radius: 16,
                        child: result.data?['getMessagesByMessageRoomId']['to']
                                    ['imageUrl'] ==
                                null
                            ? const Icon(Icons.person, size: 20)
                            : null,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        result.data?['getMessagesByMessageRoomId']['to']
                                ['name'] ??
                            '不明なユーザー',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  centerTitle: true,
                ),
              ),
              Expanded(
                child: messages.isEmpty
                    ? const Center(child: Text('メッセージがありません'))
                    : ListView.builder(
                        reverse: true,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          return MessageBubble(
                            message: message['content'],
                            isMyMessage: message['sentBy'] == userId,
                            timestamp: DateTime.parse(message['sentAt']),
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
      },
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
    if (_messageController.text.isEmpty) return;

    final userId = ref.read(authProvider).uid;
    if (userId == null) return;

    GraphQLClient client = GraphQLProvider.of(context).value;
    client.mutate(
      MutationOptions(
        document: gql('''
          mutation SendMessage(\$input: SendMessageInput!) {
            sendMessage(input: \$input) {
              id
              message
              sentAt
            }
          }
        '''),
        variables: {
          'input': {
            'roomId': widget.roomId,
            'sentBy': userId,
            'message': _messageController.text,
          },
        },
        onCompleted: (dynamic resultData) {
          _messageController.clear();
          // refetch関数を呼び出し
          _refetchMessages?.call();
        },
        onError: (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('メッセージの送信に失敗しました')),
          );
        },
      ),
    );
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
              DateFormat('yyyy/MM/dd HH:mm').format(timestamp.toLocal()),
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
