import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/presentation/providers/user_provider.dart';
import 'package:client/presentation/providers/client_provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Allocation extends ConsumerWidget {
  const Allocation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('アーティスト選択'),
        titleTextStyle: Theme.of(context).textTheme.titleMedium,
      ),
      body: userData == null || userData.belongsToArtists.isEmpty
          ? const Center(child: Text('No data'))
          : ListView.builder(
              itemCount: userData.belongsToArtists.length,
              itemBuilder: (context, index) {
                final artist = userData.belongsToArtists[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: (artist.imageUrl?.isNotEmpty ?? false)
                        ? NetworkImage(artist.imageUrl!)
                        : null,
                    child: (artist.imageUrl?.isNotEmpty ?? false)
                        ? null
                        : const Icon(Icons.person),
                  ),
                  title: Text(artist.name),
                  trailing: Text('${artist.fsp} ポイント'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MemberAllocation(
                          artistName: artist.name,
                          artistId: artist.artistId,
                          totalPoints: artist.fsp,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}

class MemberAllocation extends ConsumerStatefulWidget {
  final String artistName;
  final String artistId;
  final int totalPoints;

  const MemberAllocation({
    super.key,
    required this.artistName,
    required this.artistId,
    required this.totalPoints,
  });

  @override
  ConsumerState<MemberAllocation> createState() => _MemberAllocationState();
}

class _MemberAllocationState extends ConsumerState<MemberAllocation> {
  int _allocatedPoints = 0;
  List<UserSimpleData> members = [];
  late List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = [];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchMembers();
  }

  Future<void> _fetchMembers() async {
    try {
      final client = ref.read(graphQLClientProvider);
      final result = await client.query(
        QueryOptions(
          document: gql('''
            query GetMembers(\$artistId: String!) {
              getMembersJoinedToArtist(artistId: \$artistId) {
                id
                name
                imageUrl
              }
            }
          '''),
          variables: {
            'artistId': widget.artistId,
          },
        ),
      );

      if (result.hasException) {
        throw result.exception!;
      }

      setState(() {
        members = (result.data!['getMembersJoinedToArtist'] as List)
            .map((member) => UserSimpleData.fromJson(member))
            .toList();
        for (var controller in _controllers) {
          controller.dispose();
        }
        _controllers = List.generate(
          members.length,
          (index) => TextEditingController(text: '0'),
        );
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('メンバー一覧の取得に失敗しました: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
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
                        title: Text(member.name),
                        trailing: Text('${member.fsp} ポイント'),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onLongPress: () {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('送信されました')),
                      );
                      setState(() {
                        for (var i = 0; i < members.length; i++) {
                          members[i].fsp = 0;
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
                  '分配可能なFSP: ${widget.totalPoints}',
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
                  title: Text(member.name),
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
                          int oldPoints = member.fsp;
                          int pointsDiff = newPoints - oldPoints;

                          if (_allocatedPoints + pointsDiff <=
                              widget.totalPoints) {
                            member.fsp = newPoints;
                            _allocatedPoints += pointsDiff;
                          } else {
                            _controllers[index].text = oldPoints.toString();
                            member.fsp = oldPoints;
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
              '残りポイント: ${widget.totalPoints - _allocatedPoints}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }
}

class UserSimpleData {
  final String id;
  final String name;
  int fsp;
  final String? imageUrl;

  UserSimpleData({
    required this.id,
    required this.name,
    this.fsp = 0,
    this.imageUrl,
  });

  factory UserSimpleData.fromJson(Map<String, dynamic> json) {
    return UserSimpleData(
      id: json['id'],
      name: json['name'],
      fsp: json['fsp'] ?? 0,
      imageUrl: json['imageUrl'],
    );
  }
}
