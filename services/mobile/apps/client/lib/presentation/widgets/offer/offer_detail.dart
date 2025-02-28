import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:client/presentation/providers/client_provider.dart';
import 'package:client/presentation/providers/user_provider.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:client/presentation/widgets/offer/edit_offer.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:client/presentation/widgets/offer/manage_offer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:client/presentation/widgets/community/details.dart';

class OfferDetailPage extends ConsumerStatefulWidget {
  final int offerId;

  const OfferDetailPage({
    super.key,
    required this.offerId,
  });

  @override
  ConsumerState<OfferDetailPage> createState() => _OfferDetailPageState();
}

class _OfferDetailPageState extends ConsumerState<OfferDetailPage> {
  bool _isApplied = false;
  bool _isLoading = true;
  String? _error;
  Map<String, dynamic>? _offerData;
  bool _isInitialized = false;

  static const String getOfferQuery = '''
    query GetOfferDetail(\$offerId: Int!, \$userId: String!) {
      getOffersById(offerId: \$offerId, userId: \$userId) {
        id
        title
        status
        description
        imageUrl
        fee
        category
        place
        attention
        requiredSkill
        targetRole
        publicity
        attachedImgs
        attachedFiles
        createdAt
        updatedAt
        owner {
          id
          name
          imageUrl
        }
      }
    }
  ''';

  static const String updateOfferStatusMutation = '''
    mutation UpdateOfferStatus(\$id: Int!, \$userId: String!, \$status: String!) {
      updateOfferStatus(input: {
        id: \$id,
        userId: \$userId,
        status: \$status
      }) {
        id
        offerId
      }
    }
  ''';

  static const String reportOfferMutation = '''
    mutation ReportOffer(\$input: ReportOfferInput!) {
      reportOffer(input: \$input) {
        id
      }
    }
  ''';

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      initializeDateFormatting('ja_JP');
      _isInitialized = true;
    }
    _fetchOfferData();
  }

  Future<void> _fetchOfferData() async {
    final GraphQLClient client = ref.read(graphQLClientProvider);
    final currentUser = ref.read(userProvider);

    try {
      final QueryResult result = await client.query(
        QueryOptions(
          document: gql(getOfferQuery),
          variables: {
            'offerId': widget.offerId,
            'userId': currentUser?.id ?? '',
          },
          fetchPolicy: FetchPolicy.networkOnly,
        ),
      );

      if (result.hasException) {
        setState(() {
          _error = result.exception.toString();
          _isLoading = false;
        });
        return;
      }

      setState(() {
        _offerData = result.data?['getOffersById'];
        _isApplied = _offerData?['status'] == 'Applied';
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _applyToOffer() async {
    final GraphQLClient client = ref.read(graphQLClientProvider);
    final currentUser = ref.read(userProvider);

    try {
      final result = await client.mutate(
        MutationOptions(
          document: gql(updateOfferStatusMutation),
          variables: {
            'id': widget.offerId,
            'userId': currentUser?.id ?? '',
            'status': 'Applied',
          },
        ),
      );

      if (result.hasException) {
        print(result.exception.toString());
        return;
      }

      setState(() {
        _isApplied = true;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(child: Text('Error: $_error'));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('詳細'),
        titleTextStyle: Theme.of(context).textTheme.titleMedium,
        centerTitle: true,
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onSelected: (value) {
              if (value == 'report') {
                _showReportDialog();
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: 'report',
                child: Row(
                  children: [
                    Icon(Icons.flag_outlined, color: Colors.white, size: 20),
                    SizedBox(width: 8),
                    Text('報告する'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildArtwork(),
              SizedBox(height: 16),
              _buildTitle(),
              SizedBox(height: 16),
              _buildApplyButton(),
              SizedBox(height: 8),
              SizedBox(height: 16),
              _buildHostInfo(),
              SizedBox(height: 16),
              _buildEventDetails(),
              SizedBox(height: 16),
              _buildDescription(),
              SizedBox(height: 16),
              _buildAttention(),
              SizedBox(height: 16),
              _buildRequiredSkill(),
              SizedBox(height: 24),
              _buildAttachments(),
              SizedBox(height: 16),
              _buildPDFDownload(),
              SizedBox(height: 16),
              _buildLastUpdated(),
              SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildArtwork() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: _offerData?['imageUrl'] != null ? Colors.white : Colors.black,
        borderRadius: BorderRadius.circular(8),
        border: _offerData?['imageUrl'] == null
            ? Border.all(color: Colors.white, width: 1)
            : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: _offerData?['imageUrl'] != null
            ? Image.network(
                _offerData!['imageUrl'],
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              )
            : Center(
                child: SvgPicture.asset(
                  'assets/offer.svg',
                  width: 100, // サイズを50%程度に縮小
                  height: 100, // サイズを50%程度に縮小
                  fit: BoxFit.contain, // アイコン全体が表示されるように
                ),
              ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      _offerData?['title'] ?? '',
      style: TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildEventDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow('獲得ポイント', '${_offerData?['fee'] ?? 0} FSP'),
        _buildDetailRow('場所', _offerData?['place'] ?? ''),
        if (_offerData?['category'] != null)
          _buildDetailRow('カテゴリ', _offerData!['category']),
        if (_offerData?['targetRole'] != null)
          _buildDetailRow('対象', _offerData!['targetRole']),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(label, style: TextStyle(color: Colors.grey)),
          SizedBox(width: 8),
          Text(value, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildHostInfo() {
    final owner = _offerData?['owner'];
    return Row(
      children: [
        IntrinsicWidth(
          child: InkWell(
            onTap: () {
              if (owner?['id'] != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NodeDetailPage(id: owner['id']),
                  ),
                );
              }
            },
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: owner?['imageUrl'] != null
                      ? NetworkImage(owner['imageUrl'])
                      : null,
                ),
                SizedBox(width: 8),
                Text(owner?['name'] ?? '',
                    style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    final description = _offerData?['description'];
    if (description == null || description.isEmpty) return SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('説明', style: TextStyle(color: Colors.grey[400], fontSize: 14)),
        SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildAttention() {
    final attention = _offerData?['attention'];
    if (attention == null || attention.isEmpty) return SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('注意事項', style: TextStyle(color: Colors.grey[400], fontSize: 14)),
        SizedBox(height: 8),
        Text(
          attention,
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildRequiredSkill() {
    final requiredSkill = _offerData?['requiredSkill'];
    if (requiredSkill == null || requiredSkill.isEmpty)
      return SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('必要なスキル', style: TextStyle(color: Colors.grey[400], fontSize: 14)),
        SizedBox(height: 8),
        Text(
          requiredSkill,
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildAttachments() {
    final attachedImgs = _offerData?['attachedImgs'] as List<dynamic>? ?? [];
    if (attachedImgs.isEmpty) return SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Attachments',
            style: TextStyle(color: Colors.white, fontSize: 18)),
        SizedBox(height: 8),
        Row(
          children: attachedImgs
              .map((imgUrl) => Expanded(
                    child: GestureDetector(
                      onTap: () => _showFullScreenImage(context, imgUrl),
                      child: Container(
                        height: 100,
                        margin: EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(imgUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }

  void _showFullScreenImage(BuildContext context, String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            iconTheme: IconThemeData(color: Colors.white),
          ),
          body: Center(
            child: InteractiveViewer(
              minScale: 0.5,
              maxScale: 4.0,
              child: Image.network(
                imageUrl,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPDFDownload() {
    final attachedFiles = _offerData?['attachedFiles'] as List<dynamic>? ?? [];
    if (attachedFiles.isEmpty) return SizedBox.shrink();

    return Column(
      children: attachedFiles.map((file) {
        if (file is String) {
          final fileUrl = file;
          final fileName = _extractFileName(fileUrl);
          final extension = _getFileExtension(fileUrl);
          final isAudio = _isAudioFile(extension);

          return _buildFileDownloadItem(
            name: fileName,
            extension: extension,
            url: fileUrl,
            isAudio: isAudio,
          );
        }
        return SizedBox.shrink();
      }).toList(),
    );
  }

  String _extractFileName(String url) {
    try {
      final uri = Uri.parse(url);
      final encodedFileName = uri.pathSegments.last.split('?')[0];

      // ファイル名からタイムスタンプ部分を除去
      final parts = encodedFileName.split('_');
      if (parts.length > 1) {
        // 最初のパート（タイムスタンプ）を除外して結合
        final nameWithoutTimestamp = parts.sublist(1).join('_');
        // 拡張子を除外
        final nameWithoutExtension = nameWithoutTimestamp.split('.')[0];

        // デコード処理を try-catch で囲む
        try {
          return Uri.decodeComponent(nameWithoutExtension);
        } catch (e) {
          // デコードに失敗した場合は、デコードせずに返す
          return nameWithoutExtension;
        }
      }
      return encodedFileName;
    } catch (e) {
      // URIのパース失敗時は空の文字列を返す
      return '';
    }
  }

  String _getFileExtension(String url) {
    try {
      final fileName = url.split('?')[0];
      final parts = fileName.split('.');
      if (parts.length > 1) {
        return parts.last.toUpperCase();
      }
      return '';
    } catch (e) {
      return '';
    }
  }

  bool _isAudioFile(String extension) {
    final audioExtensions = ['MP3', 'WAV', 'M4A', 'OGG'];
    return audioExtensions.contains(extension.toUpperCase());
  }

  Widget _buildFileDownloadItem({
    required String name,
    required String extension,
    required String url,
    required bool isAudio,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(45),
        border: Border.all(color: Colors.white, width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                extension,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              name,
              style: TextStyle(color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            icon: Icon(Icons.download, color: Colors.white, size: 16),
            onPressed: () => _downloadFile(url),
          ),
        ],
      ),
    );
  }

  Future<void> _downloadFile(String? url) async {
    if (url == null) return;

    try {
      final dio = Dio();
      final originalFileName = url.split('/').last.split('?')[0];

      // ファイル名を短く処理する
      final String safeFileName = _createSafeFileName(originalFileName);

      // ダウンロード先のディレクトリを取得
      final dir = Platform.isAndroid
          ? await getExternalStorageDirectory()
          : await getApplicationDocumentsDirectory();

      if (dir == null) {
        throw Exception('ダウンロードディレクトリが見つかりません');
      }

      final filePath = '${dir.path}/$safeFileName';

      // ファイルをダウンロード
      await dio.download(
        url,
        filePath,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('ダウンロードが完了しました'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('ダウンロードに失敗しました'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  String _createSafeFileName(String originalFileName) {
    try {
      // タイムスタンプ部分を除去
      final parts = originalFileName.split('_');
      if (parts.length > 1) {
        parts.removeAt(0); // 最初のタイムスタンプ部分を削除
      }

      // 残りの部分を結合
      String fileName = parts.join('_');

      // デコード処理を試みる
      try {
        fileName = Uri.decodeComponent(fileName);
      } catch (e) {
        // デコードに失敗した場合は元のファイル名を使用
      }

      // 拡張子を取得
      final extension = fileName.split('.').last;
      // ファイル名部分を取得（拡張子を除く）
      final nameWithoutExtension =
          fileName.substring(0, fileName.length - extension.length - 1);

      // ファイル名を32文字に制限（拡張子は除く）
      String truncatedName = nameWithoutExtension;
      if (truncatedName.length > 32) {
        truncatedName = truncatedName.substring(0, 32);
      }

      // 拡張子を付けて返す
      return '$truncatedName.$extension';
    } catch (e) {
      // エラーが発生した場合は、タイムスタンプ付きの汎用的な名前を返す
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      return 'download_$timestamp.file';
    }
  }

  Widget _buildApplyButton() {
    final currentUser = ref.read(userProvider);
    final isOwner = _offerData?['owner']?['id'] == currentUser?.id;
    final isPublic = _offerData?['publicity'] ?? false;

    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: isOwner
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ManageOfferPage(
                          offerId: widget.offerId,
                          userId: currentUser?.id ?? '',
                        ),
                      ),
                    );
                  }
                : (!isPublic || _isApplied || _offerData?['status'] != null
                    ? null // 非公開、Applied済み、またはステータスがある場合は無効化
                    : _showConfirmationDialog),
            style: ElevatedButton.styleFrom(
              backgroundColor: isOwner
                  ? const Color(0xFFE4DBC0)
                  : (_offerData?['status'] != null
                      ? Colors.grey
                      : const Color(0xFFE4DBC0)),
              padding: EdgeInsets.symmetric(vertical: 12),
            ),
            child: Text(
              isOwner
                  ? 'Offerを管理する'
                  : (_offerData?['status'] != null
                      ? _offerData!['status']
                      : (!isPublic
                          ? '現在応募できません'
                          : (_isApplied ? 'Applied' : 'このOfferに申し込む'))),
              style: TextStyle(
                fontSize: 16,
                color: _isApplied || _offerData?['status'] != null
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ),
        ),
        if (isOwner) ...[
          SizedBox(width: 8),
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onSelected: (value) {
              switch (value) {
                case 'edit':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          EditOfferPage(offerId: widget.offerId),
                    ),
                  ).then((result) {
                    if (result == true) {
                      _fetchOfferData();
                    }
                  });
                  break;
                case 'delete':
                  _showDeleteConfirmationDialog();
                  break;
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(Icons.edit, color: Colors.white, size: 20),
                    SizedBox(width: 8),
                    Text('編集する'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete, color: Colors.red, size: 20),
                    SizedBox(width: 8),
                    Text('削除する', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('確認'),
          content: Text('本当に申し込みますか？'),
          actions: <Widget>[
            TextButton(
              child: Text('キャンセル'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('確認'),
              onPressed: () async {
                Navigator.of(context).pop();
                await _applyToOffer();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('確認'),
          content: Text('このOfferを削除してもよろしいですか？'),
          actions: <Widget>[
            TextButton(
              child: Text('キャンセル'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                '削除する',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _deleteOffer();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteOffer() async {
    const String deleteMutation = '''
      mutation DeleteOffer(\$input: DeleteOfferInput!) {
        deleteOffer(input: \$input) {
          id
        }
      }
    ''';

    try {
      final GraphQLClient client = ref.read(graphQLClientProvider);
      final result = await client.mutate(
        MutationOptions(
          document: gql(deleteMutation),
          variables: {
            'input': {
              'id': widget.offerId,
            },
          },
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception.toString());
      }

      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Offerを削除しました')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('削除に失敗しました: ${e.toString()}')),
      );
    }
  }

  Widget _buildLastUpdated() {
    String formattedDate = '';
    if (_offerData?['updatedAt'] != null) {
      final DateTime updatedAt = DateTime.parse(_offerData!['updatedAt']);
      final DateFormat formatter = DateFormat('yyyy年MM月dd日', 'ja_JP');
      formattedDate = formatter.format(updatedAt.toLocal());
    }

    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        '最終更新: $formattedDate',
        style: TextStyle(color: Colors.grey),
      ),
    );
  }

  void _showReportDialog() {
    final TextEditingController commentController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Offerを報告'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('このOfferについて問題がある場合は報告してください。'),
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
                // まずダイアログを閉じてから報告処理を実行
                Navigator.of(context).pop();
                _submitReport(commentController.text);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _submitReport(String comment) async {
    try {
      final GraphQLClient client = ref.read(graphQLClientProvider);
      final currentUser = ref.read(userProvider);

      final result = await client.mutate(
        MutationOptions(
          document: gql(reportOfferMutation),
          variables: {
            'input': {
              'offerId': widget.offerId,
              'reporterUserId': currentUser?.id ?? '',
              'reportContent': comment.trim().isEmpty ? '' : comment.trim(),
            },
          },
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception.toString());
      }

      // 完了ダイアログを表示
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
}
