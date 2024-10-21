import 'package:flutter/material.dart';

class OfferDetailPage extends StatefulWidget {
  const OfferDetailPage({super.key});

  @override
  State<OfferDetailPage> createState() => _OfferDetailPageState();
}

class _OfferDetailPageState extends State<OfferDetailPage> {
  bool _isApplied = false;

  @override
  Widget build(BuildContext context) {
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
              _buildEventDetails(),
              SizedBox(height: 16),
              _buildHostInfo(),
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
      ),
      // TODO: Implement artwork
    );
  }

  Widget _buildCategories() {
    return Row(
      children: [
        _buildCategoryChip('Category 01', Colors.orange),
        SizedBox(width: 8),
        _buildCategoryChip('Category 02', Colors.purple),
        SizedBox(width: 8),
        _buildCategoryChip('Category 03', Colors.green),
      ],
    );
  }

  Widget _buildCategoryChip(String label, Color color) {
    return Chip(
      label: Text(label),
      backgroundColor: color,
    );
  }

  Widget _buildTitle() {
    return Text(
      'イベントに参加してくれるアーティスト募集中！\n2行目の場合こう見えます。2行目の場合こう見えます。',
      style: TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildLastUpdated() {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        'Last Updated: 2024/10/10',
        style: TextStyle(color: Colors.grey),
      ),
    );
  }

  Widget _buildEventDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow('獲得ポイント', '1,000 FSP'),
        _buildDetailRow('期限', '2024/10/31'),
        _buildDetailRow('場所', '東京都'),
        _buildDetailRow('対象', '2 Artists'),
        _buildDetailRow('カテゴリ', 'Music'),
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
    return Row(
      children: [
        CircleAvatar(
            // TODO: Implement host avatar
            ),
        SizedBox(width: 8),
        Text('brady_nakayama', style: TextStyle(color: Colors.white)),
        SizedBox(width: 8),
        Text('4 connections', style: TextStyle(color: Colors.grey)),
        SizedBox(width: 8),
      ],
    );
  }

  Widget _buildDescription() {
    return Text(
      'ここにオファーの概要が入ります。音楽シーンを盛り上げるための特別なイベントに参加してくれるアーティストを大募集しています！このイベントは、あなたの音楽を新しいリスナーに届ける絶好のチャンスです。才能あふれるアーティスト同士が集まり、共にクリエイティブなコラボレーションを楽しみながら、音楽の未来を切り開きましょう。\n\n参加者は、経験豊富なプロフェッショナルとネットワークを広げるだけでなく、音楽業界での知名度を高める貴重な機会を得ることができます。あなたの音楽が、多くのリスナーに響き渡る瞬間を一緒に作り上げませんか？是非、この素晴らしい機会をお見逃しなく！',
      style: TextStyle(color: Colors.white),
    );
  }

  Widget _buildAttachments() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Attachments',
            style: TextStyle(color: Colors.white, fontSize: 18)),
        SizedBox(height: 8),
        Row(
          children: List.generate(
              3,
              (index) => Expanded(
                    child: Container(
                      height: 100,
                      margin: EdgeInsets.only(right: index < 2 ? 8 : 0),
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  )),
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
}
