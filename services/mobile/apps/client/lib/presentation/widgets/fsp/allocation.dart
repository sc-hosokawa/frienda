import 'package:flutter/material.dart';

class Allocation extends StatelessWidget {
  const Allocation({super.key});

  @override
  Widget build(BuildContext context) {
    // ダミーデータを作成（実際のアプリケーションではデータソースから取得します）
    final artists = [
      {
        'name': 'アーティスト1',
        'image': 'assets/logo_visualonly.jpg',
        'points': 1000
      },
      {
        'name': 'アーティスト2',
        'image': 'assets/logo_visualonly.jpg',
        'points': 1500
      },
      {'name': 'アーティスト3', 'image': 'assets/logo_visualonly.jpg', 'points': 800},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('アーティスト選択'),
        titleTextStyle: Theme.of(context).textTheme.titleMedium,
      ),
      body: ListView.builder(
        itemCount: artists.length,
        itemBuilder: (context, index) {
          final artist = artists[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(artist['image'] as String),
            ),
            title: Text(artist['name'] as String),
            trailing: Text('${artist['points']} ポイント'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      MemberAllocation(artistName: artist['name'] as String),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class MemberAllocation extends StatefulWidget {
  final String artistName;

  const MemberAllocation({super.key, required this.artistName});

  @override
  _MemberAllocationState createState() => _MemberAllocationState();
}

class _MemberAllocationState extends State<MemberAllocation> {
  // 分配可能な合計ポイント数
  final int totalPoints = 1000;

  // 現在割り当てられているポイントの合計
  int _allocatedPoints = 0;

  // ダミーデータ（実際のアプリケーションではデータソースから取得します）
  final List<Map<String, dynamic>> members = [
    {'name': 'メンバー1', 'points': 0},
    {'name': 'メンバー2', 'points': 0},
    {'name': 'メンバー3', 'points': 0},
  ];

  // TextEditingControllerのリストを追加
  late List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    // 各メンバーに対応するTextEditingControllerを初期化
    _controllers = List.generate(
      members.length,
      (index) => TextEditingController(text: '0'),
    );
  }

  @override
  void dispose() {
    // コントローラーを破棄
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _showConfirmationModal() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '入力内容の確認',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: members.length,
                    itemBuilder: (context, index) {
                      final member = members[index];
                      return ListTile(
                        title: Text(member['name'] as String),
                        trailing: Text('${member['points']} ポイント'),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onLongPress: () {
                      // TODO: 実際の送信処理を実装
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('送信されました')),
                      );
                      // フォーム内容をクリア
                      setState(() {
                        for (var i = 0; i < members.length; i++) {
                          members[i]['points'] = 0;
                          _controllers[i].text = '0';
                        }
                        _allocatedPoints = 0;
                      });
                    },
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('送付（1秒間長押し）'),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.artistName}のメンバー'),
        titleTextStyle: Theme.of(context).textTheme.titleMedium,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '分配可能なFSP: $totalPoints',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                ElevatedButton(
                  onPressed: _showConfirmationModal,
                  child: const Text('送付'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: members.length,
              itemBuilder: (context, index) {
                final member = members[index];
                return ListTile(
                  title: Text(member['name'] as String),
                  trailing: SizedBox(
                    width: 100,
                    child: TextField(
                      controller: _controllers[index],
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'ポイント',
                        border: UnderlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                      ),
                      textAlign: TextAlign.end,
                      onChanged: (value) {
                        setState(() {
                          int newPoints = int.tryParse(value) ?? 0;
                          int oldPoints = member['points'] as int;
                          int pointsDiff = newPoints - oldPoints;

                          if (_allocatedPoints + pointsDiff <= totalPoints) {
                            member['points'] = newPoints;
                            _allocatedPoints += pointsDiff;
                          } else {
                            // ポイントが超過する場合、入力を元に戻す
                            _controllers[index].text = oldPoints.toString();
                            member['points'] = oldPoints;
                          }
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '残りポイント: ${totalPoints - _allocatedPoints}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }
}
