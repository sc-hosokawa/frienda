import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  final List<Map<String, String>> faqItems = const [
    {
      'question': 'アプリの使い方がわかりません',
      'answer': 'アプリの基本的な使い方については、ホーム画面の「使い方ガイド」をご覧ください。詳細な操作方法や機能の説明が記載されています。'
    },
    {
      'question': 'パスワードを忘れてしまいました',
      'answer':
          'ログイン画面の「パスワードを忘れた方」リンクをタップし、登録されているメールアドレスを入力してください。パスワードリセットの手順をメールでお送りします。'
    },
    {
      'question': 'アカウントを削除したいです',
      'answer':
          '設定画面の「アカウント設定」から「アカウント削除」を選択してください。注意：アカウントを削除すると、すべてのデータが永久に失われます。'
    },
    // 必要に応じて他のFAQ項目を追加してください
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('よくある質問'),
      ),
      body: ListView.builder(
        itemCount: faqItems.length,
        itemBuilder: (context, index) {
          return FAQItem(
            question: faqItems[index]['question']!,
            answer: faqItems[index]['answer']!,
          );
        },
      ),
    );
  }
}

class FAQItem extends StatefulWidget {
  final String question;
  final String answer;

  const FAQItem({super.key, required this.question, required this.answer});

  @override
  _FAQItemState createState() => _FAQItemState();
}

class _FAQItemState extends State<FAQItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text(
            widget.question,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          onExpansionChanged: (expanded) {
            setState(() {
              _expanded = expanded;
            });
          },
          maintainState: true,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(widget.answer),
            ),
          ],
        ),
      ),
    );
  }
}
