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
          // IconButton(icon: Icon(Icons.share), onPressed: () {}),
          // IconButton(icon: Icon(Icons.favorite_border), onPressed: () {}),
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        image: _offerData?['imageUrl'] != null
            ? DecorationImage(
                image: NetworkImage(_offerData!['imageUrl']),
                fit: BoxFit.cover,
              )
            : null,
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
        CircleAvatar(
          backgroundImage: owner?['imageUrl'] != null
              ? NetworkImage(owner['imageUrl'])
              : null,
        ),
        SizedBox(width: 8),
        Text(owner?['name'] ?? '', style: TextStyle(color: Colors.white)),
      ],
    );
  }

  Widget _buildDescription() {
    return Text(
      _offerData?['description'] ?? '',
      style: TextStyle(color: Colors.white),
    );
  }

  Widget _buildAttention() {
    return Text(
      _offerData?['attention'] ?? '',
      style: TextStyle(color: Colors.white),
    );
  }

  Widget _buildRequiredSkill() {
    return Text(
      _offerData?['requiredSkill'] ?? '',
      style: TextStyle(color: Colors.white),
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
        return Container(
          margin: EdgeInsets.only(bottom: 8),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            children: [
              Icon(Icons.picture_as_pdf, color: Colors.white),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(file['name'] ?? '不明なファイル',
                        style: TextStyle(color: Colors.white)),
                    Text('${file['size'] ?? '不明'} MB',
                        style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.download, color: Colors.white),
                onPressed: () => _downloadFile(file['url']),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Future<void> _downloadFile(String? url) async {
    if (url == null) return;

    try {
      // ダウンロード中の進捗を表示
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('ダウンロード中...'),
              ],
            ),
          );
        },
      );

      final dio = Dio();
      final fileName = url.split('/').last;

      // ダウンロード先のディレクトリを取得
      final dir = Platform.isAndroid
          ? await getExternalStorageDirectory() // Android
          : await getApplicationDocumentsDirectory(); // iOS

      if (dir == null) {
        throw Exception('ダウンロードディレクトリが見つかりません');
      }

      final filePath = '${dir.path}/$fileName';

      // ファイルをダウンロード
      await dio.download(
        url,
        filePath,
      );

      // ダウンロード完了後、ダイアログを閉じる
      if (mounted) {
        Navigator.pop(context); // プログレスダイアログを閉じる

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('ダウンロードが完了しました\n保存先: $filePath'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      // エラー時、ダイアログを閉じてエラーメッセージを表示
      if (mounted) {
        Navigator.pop(context); // プログレスダイアログを閉じる

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('ダウンロードに失敗しました: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Widget _buildApplyButton() {
    final currentUser = ref.read(userProvider);
    final isOwner = _offerData?['owner']?['id'] == currentUser?.id;

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
                : (_isApplied ? null : _showConfirmationDialog),
            style: ElevatedButton.styleFrom(
              backgroundColor: isOwner
                  ? const Color(0xFFE4DBC0)
                  : (_isApplied ? Colors.grey : const Color(0xFFE4DBC0)),
              padding: EdgeInsets.symmetric(vertical: 12),
            ),
            child: Text(
              isOwner
                  ? 'Offerを管理する'
                  : (_isApplied ? 'Applied' : 'このOfferに申し込む'),
              style: TextStyle(
                fontSize: 16,
                color: _isApplied ? Colors.white : Colors.black,
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
}
