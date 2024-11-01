import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:client/presentation/providers/client_provider.dart';

class OfferDetailPage extends StatefulWidget {
  final int offerId;

  const OfferDetailPage({
    super.key,
    required this.offerId,
  });

  @override
  State<OfferDetailPage> createState() => _OfferDetailPageState();
}

class _OfferDetailPageState extends State<OfferDetailPage> {
  bool _isApplied = false;
  bool _isLoading = true;
  String? _error;
  Map<String, dynamic>? _offerData;
  bool _isInitialized = false;

  static const String getOfferQuery = '''
    query GetOfferDetail(\$offerId: Int!) {
      getOffersById(offerId: \$offerId) {
        id
        title
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      _fetchOfferData();
      _isInitialized = true;
    }
  }

  Future<void> _fetchOfferData() async {
    final GraphQLClient client = GraphQLProvider.of(context).value;

    try {
      final QueryResult result = await client.query(
        QueryOptions(
          document: gql(getOfferQuery),
          variables: {
            'offerId': widget.offerId,
          },
        ),
      );

      if (result.hasException) {
        setState(() {
          _error = result.exception.toString();
          _isLoading = false;
        });
        return;
      }

      print(result);

      setState(() {
        _offerData = result.data?['getOffersById'];
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
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
              .take(3)
              .map((imgUrl) => Expanded(
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
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildPDFDownload() {
    return Container(
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
                Text('ファイル名が入ります。ファイル名が入ります。',
                    style: TextStyle(color: Colors.white)),
                Text('1.0 MB', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          Icon(Icons.download, color: Colors.white),
        ],
      ),
    );
  }

  Widget _buildApplyButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isApplied ? null : _showConfirmationDialog,
        style: ElevatedButton.styleFrom(
          backgroundColor: _isApplied ? Colors.grey : Colors.lightGreen,
          padding: EdgeInsets.symmetric(vertical: 12),
        ),
        child: Text(
          _isApplied ? 'Applied' : 'このOfferに申し込む',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
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
              onPressed: () {
                setState(() {
                  _isApplied = true;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildLastUpdated() {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        'Last Updated: ${_offerData?['updatedAt'] ?? ''}',
        style: TextStyle(color: Colors.grey),
      ),
    );
  }
}
