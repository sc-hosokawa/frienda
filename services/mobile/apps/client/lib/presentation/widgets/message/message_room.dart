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
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;
import 'package:client/presentation/widgets/message/message_list.dart';

class MessageRoom extends ConsumerStatefulWidget {
  const MessageRoom({super.key, required this.roomId});

  final String roomId;

  @override
  ConsumerState<MessageRoom> createState() => _MessageRoomState();
}

class _MessageRoomState extends ConsumerState<MessageRoom> {
  final TextEditingController _messageController = TextEditingController();

  Refetch? _refetchMessages;

  static const String reportUserMutation = '''
    mutation ReportUser(\$input: ReportUserInput!) {
      reportUser(input: \$input) {
        id
      }
    }
  ''';

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
                attachedFile
                attachedImg
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

        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    backgroundImage: result.data?['getMessagesByMessageRoomId']
                                ['to']['imageUrl'] !=
                            null
                        ? NetworkImage(
                            result.data!['getMessagesByMessageRoomId']['to']
                                ['imageUrl'] as String)
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
                    result.data?['getMessagesByMessageRoomId']['to']['name'] ??
                        '不明なユーザー',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              centerTitle: true,
              actions: [
                PopupMenuButton<String>(
                  icon: Icon(Icons.more_vert, color: Colors.white),
                  onSelected: (value) {
                    if (value == 'report') {
                      _showReportDialog(result
                          .data?['getMessagesByMessageRoomId']['to']['id']);
                    } else if (value == 'block') {
                      _showBlockConfirmationDialog(result
                          .data?['getMessagesByMessageRoomId']['to']['id']);
                    }
                  },
                  itemBuilder: (BuildContext context) => [
                    PopupMenuItem<String>(
                      value: 'report',
                      child: Row(
                        children: [
                          Icon(Icons.flag_outlined,
                              color: Colors.white, size: 20),
                          SizedBox(width: 8),
                          Text('ユーザーを報告'),
                        ],
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'block',
                      child: Row(
                        children: [
                          Icon(Icons.block, color: Colors.red, size: 20),
                          SizedBox(width: 8),
                          Text('ユーザーをブロック',
                              style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            body: Column(
              children: [
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
                              attachedFile: message['attachedFile'],
                              attachedImg: message['attachedImg'],
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
                        icon: Icon(Icons.add, color: Colors.white),
                        onPressed: _attachFile,
                      ),
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: 'メッセージを入力...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            filled: true,
                            fillColor: Theme.of(context).cardColor,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      IconButton(
                        icon: Icon(Icons.send, color: Colors.white),
                        onPressed: _sendMessage,
                      ),
                    ],
                  ),
                ),
              ],
            ),
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

  Future<String?> _uploadImageToCloudStorage(XFile image) async {
    try {
      File imageFile = File(image.path);
      FirebaseStorage storage = FirebaseStorage.instance;
      String fileName =
          'msg/images/${DateTime.now().millisecondsSinceEpoch}_${image.name}';
      Reference ref = storage.ref().child(fileName);

      // メタデータを設定
      final metadata = SettableMetadata(
        contentType: _getImageContentType(image.name),
      );

      UploadTask uploadTask = ref.putFile(imageFile, metadata);

      // アップロード完了を待機
      await uploadTask;

      // アップロードされた画像のURLを取得
      String downloadURL = await ref.getDownloadURL();
      print('Image uploaded successfully. URL: $downloadURL');

      return downloadURL;
    } catch (e) {
      print('Error uploading image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('画像のアップロードに失敗しました: ${e.toString()}')),
      );
      return null;
    }
  }

  Future<String?> _uploadFileToCloudStorage(PlatformFile file) async {
    try {
      File fileToUpload = File(file.path!);
      FirebaseStorage storage = FirebaseStorage.instance;
      String fileName =
          'msg/files/${DateTime.now().millisecondsSinceEpoch}_${file.name}';
      Reference ref = storage.ref().child(fileName);

      // メタデータを設定
      final metadata = SettableMetadata(
        contentType: file.extension != null
            ? 'application/${file.extension}'
            : 'application/octet-stream',
      );

      UploadTask uploadTask = ref.putFile(fileToUpload, metadata);

      // アップロード完了を待機
      await uploadTask;

      // アップロードされたファイルのURLを取得
      String downloadURL = await ref.getDownloadURL();
      print('File uploaded successfully. URL: $downloadURL');

      return downloadURL;
    } catch (e) {
      print('Error uploading file: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('ファイルのアップロードに失敗しました: ${e.toString()}')),
      );
      return null;
    }
  }

  String _getImageContentType(String fileName) {
    final extension = fileName.toLowerCase().split('.').last;
    switch (extension) {
      case 'png':
        return 'image/png';
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'gif':
        return 'image/gif';
      case 'webp':
        return 'image/webp';
      case 'heic':
        return 'image/heic';
      case 'heif':
        return 'image/heif';
      default:
        return 'image/jpeg';
    }
  }

  void _pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null) {
        final String? downloadURL = await _uploadImageToCloudStorage(image);
        if (downloadURL != null) {
          _sendMessage(attachedImages: [downloadURL]);
        }
      }
    } catch (e) {
      print('Error picking image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('画像の選択に失敗しました')),
      );
    }
  }

  void _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        PlatformFile file = result.files.first;
        if (file.size > 10 * 1024 * 1024) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('ファイルサイズは10MB以下にしてください')),
          );
          return;
        }

        final String? downloadURL = await _uploadFileToCloudStorage(file);
        if (downloadURL != null) {
          _sendMessage(attachedFiles: [downloadURL]);
        }
      }
    } catch (e) {
      print('Error picking file: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('ファイルの選択に失敗しました')),
      );
    }
  }

  void _sendMessage(
      {List<String>? attachedImages, List<String>? attachedFiles}) {
    if (_messageController.text.isEmpty &&
        (attachedImages == null || attachedImages.isEmpty) &&
        (attachedFiles == null || attachedFiles.isEmpty)) return;

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
              attachedFile
              attachedImg
            }
          }
        '''),
        variables: {
          'input': {
            'roomId': widget.roomId,
            'sentBy': userId,
            'message': _messageController.text,
            if (attachedFiles != null && attachedFiles.isNotEmpty)
              'attachedFile': attachedFiles,
            if (attachedImages != null && attachedImages.isNotEmpty)
              'attachedImg': attachedImages,
          },
        },
        onCompleted: (dynamic resultData) {
          _messageController.clear();
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

  void _showReportDialog(String? targetUserId) {
    if (targetUserId == null) return;

    final TextEditingController commentController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('ユーザーを報告'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('このユーザーについて問題がある場合は報告してください。'),
              SizedBox(height: 16),
              TextField(
                controller: commentController,
                decoration: InputDecoration(
                  hintText: 'コメント（任意）',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('キャンセル'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              child: Text('報告する'),
              onPressed: () {
                Navigator.of(context).pop();
                _submitReport(targetUserId, commentController.text);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _submitReport(String targetUserId, String comment) async {
    try {
      final userId = ref.read(authProvider).uid;
      if (userId == null) return;

      GraphQLClient client = GraphQLProvider.of(context).value;
      final result = await client.mutate(
        MutationOptions(
          document: gql(reportUserMutation),
          variables: {
            'input': {
              'reportedUserId': targetUserId,
              'reporterUserId': userId,
              'reportContent': comment.trim().isEmpty ? '' : comment.trim(),
            },
          },
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception.toString());
      }

      if (mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('ご協力ありがとうございます'),
              content: Text('報告を受け付けました。'),
              actions: [
                TextButton(
                  child: Text('閉じる'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('報告に失敗しました: ${e.toString()}')),
        );
      }
    }
  }

  void _showBlockConfirmationDialog(String? targetUserId) {
    if (targetUserId == null) return;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('ブロックの確認'),
          content:
              Text('このユーザーをブロックしますか？\n\nブロックすると、このユーザーとのメッセージのやり取りができなくなります。'),
          actions: [
            TextButton(
              child: Text('キャンセル'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: Text('ブロックする'),
              onPressed: () {
                Navigator.of(context).pop();
                _blockUser(targetUserId);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _blockUser(String targetUserId) async {
    try {
      final userId = ref.read(authProvider).uid;
      if (userId == null) return;

      GraphQLClient client = GraphQLProvider.of(context).value;
      final result = await client.mutate(
        MutationOptions(
          document: gql('''
            mutation BlockUser(\$input: BlockUserInput!) {
              blockUser(input: \$input) {
                id
              }
            }
          '''),
          variables: {
            'input': {
              'blockedUserId': targetUserId,
              'blockerUserId': userId,
            },
          },
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception.toString());
      }

      if (mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('ブロックしました'),
              content: Text('このユーザーをブロックしました。'),
              actions: [
                TextButton(
                  child: Text('閉じる'),
                  onPressed: () {
                    // ダイアログを閉じる
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('ブロックに失敗しました: ${e.toString()}')),
        );
      }
    }
  }
}

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMyMessage;
  final String? attachedFile;
  final String? attachedImg;
  final DateTime timestamp;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isMyMessage,
    required this.timestamp,
    this.attachedFile,
    this.attachedImg,
  });

  Future<void> _downloadFile(
      BuildContext context, String url, bool isImage) async {
    try {
      // Android 13以降の場合、明示的な権限リクエストが必要
      if (Platform.isAndroid) {
        final status = await Permission.storage.request();
        if (!status.isGranted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('ストレージの権限が必要です')),
          );
          return;
        }
      }

      // ダウンロード開始を通知
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('ダウンロードを開始しました')),
      );

      final dio = Dio();
      final response = await dio.get(
        url,
        options: Options(responseType: ResponseType.bytes),
      );

      // ファイル名を生成（URLから取得するか、タイムスタンプを使用）
      final fileName = path.basename(url).contains('?')
          ? '${DateTime.now().millisecondsSinceEpoch}${isImage ? '.jpg' : ''}'
          : path.basename(url);

      // 保存先ディレクトリを取得
      final directory = Platform.isAndroid
          ? Directory('/storage/emulated/0/Download')
          : await getApplicationDocumentsDirectory();

      if (Platform.isAndroid && !await directory.exists()) {
        directory.createSync(recursive: true);
      }

      final filePath = path.join(directory.path, fileName);
      final file = File(filePath);
      await file.writeAsBytes(response.data);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('ダウンロードが完了しました'),
          duration: Duration(seconds: 5),
        ),
      );
    } catch (e) {
      print('Download error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('ダウンロードに失敗しました')),
      );
    }
  }

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
            if (message.isNotEmpty)
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color:
                      isMyMessage ? const Color(0xFFE4DBC0) : Colors.grey[300],
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
            if (message.isNotEmpty &&
                (attachedFile != null || attachedImg != null))
              SizedBox(height: 8),
            if (attachedFile != null)
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isMyMessage
                      ? const Color(0xFFE4DBC0).withOpacity(0.7)
                      : Colors.grey[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.attachment, size: 20),
                    SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        '添付ファイル',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.download),
                      onPressed: () =>
                          _downloadFile(context, attachedFile!, false),
                    ),
                  ],
                ),
              ),
            if (attachedImg != null)
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    Image.network(
                      attachedImg!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.download, color: Colors.white),
                          onPressed: () =>
                              _downloadFile(context, attachedImg!, true),
                        ),
                      ),
                    ),
                  ],
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
