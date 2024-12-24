import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_graph_view/flutter_graph_view.dart';
import 'package:client/presentation/widgets/community/details.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:client/data/model/community/member.dart';
import 'package:client/presentation/providers/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/presentation/widgets/community/community_map.dart';

// GraphQLクエリの定義
final GET_OWN_COMMUNITY = gql('''
  query GetOwnCommunity(\$userId: String!) {
    getOwnCommunity(userId: \$userId) {
      community {
        id
        name
        imageUrl
        category
        favoriteId
        shortNoteId
        shortNote
        lastLoggedIn
        connections
        weight
      }
    }
  }
''');

Map<String, Vertex> vertexStorage = {};

const String markFavoriteMutation = '''
  mutation MarkFavorite(\$targetUserId: String!, \$likedBy: String!) {
    markFavorite(targetUserId: \$targetUserId, likedBy: \$likedBy) {
      id
    }
  }
''';

const String unmarkFavoriteMutation = '''
  mutation UnmarkFavorite(\$favoriteId: String!) {
    unmarkFavorite(favoriteId: \$favoriteId) {
      id
    }
  }
''';

// GraphQL mutationの定義を修正
const String addShortNoteMutation = '''
  mutation AddShortNote(\$writer: String!, \$toUser: String!, \$comment: String!) {
    addShortnote(writer: \$writer, toUser: \$toUser, comment: \$comment) {
      id
    }
  }
''';

const String editShortNoteMutation = '''
  mutation EditShortNote(\$shortnoteId: String!, \$comment: String!) {
    editShortnote(shortnoteId: \$shortnoteId, comment: \$comment) {
      id
    }
  }
''';

class Community extends ConsumerStatefulWidget {
  const Community({super.key});

  @override
  ConsumerState<Community> createState() => _CommunityState();
}

class _CommunityState extends ConsumerState<Community> {
  String _selectedView = 'List View';
  List<CommunityMember> communityMembers = [];

  void saveVertex(Vertex v) {
    vertexStorage[v.id as String] = v;
  }

  Map<String, Vertex?> loadVertex() {
    return vertexStorage;
  }

  // 円形レイアウトの初期位置を計算する関数
  Map<String, Offset> calculateInitialPositions(
      double radius, bool isHalfCircle) {
    Map<String, Offset> positions = {};
    int nodeCount = 9; // node1からnode9まで

    // 中心のnode0の位置
    positions['node0'] = const Offset(0, 0);

    // 周りのノードの位置を計算
    for (int i = 1; i <= nodeCount; i++) {
      // 角度の計算（半円の場合は180度、円の場合は360度で分割）
      double angle = (isHalfCircle ? pi : 2 * pi) * (i - 1) / nodeCount;
      if (isHalfCircle) {
        // 半円の場合は角度を調整（0°から180°の範囲にする）
        angle = pi - angle;
      }

      // 極座標から直交座標に変換
      double x = radius * cos(angle);
      double y = radius * sin(angle);

      positions['node$i'] = Offset(x, y);
    }

    return positions;
  }

  @override
  Widget build(BuildContext context) {
    final userId = ref.watch(userProvider)?.id ?? '';
    return Query(
      options: QueryOptions(
        document: GET_OWN_COMMUNITY,
        variables: {
          'userId': userId,
        },
        fetchPolicy: FetchPolicy.cacheAndNetwork,
      ),
      builder: (QueryResult result,
          {VoidCallback? refetch, FetchMore? fetchMore}) {
        if (result.hasException) {
          return Center(child: Text('Error: ${result.exception.toString()}'));
        }

        if (result.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = result.data;
        if (data == null) {
          return const Center(child: Text('No connection yet'));
        }

        final communityData = (data['getOwnCommunity']['community'] as List?)
            ?.map((item) => item as Map<String, dynamic>)
            .toList();

        if (communityData == null || communityData.isEmpty) {
          return const Center(child: Text('No connection yet'));
        }

        communityMembers = communityData
            .map((data) => CommunityMember.fromJson(data))
            .toList();

        return Column(
          children: [
            /*
            DropdownButton<String>(
              value: _selectedView,
              items: ['List View', '(beta) Map View']
                  .map((String value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ))
                  .toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedView = newValue;
                  });
                }
              },
            ),
            */
            Expanded(
              child: _buildListView(communityMembers, userId, refetch),
            ),
          ],
        );
      },
    );
  }

  Widget _buildListView(
      List<CommunityMember> members, String userId, VoidCallback? refetch) {
    return ListView.builder(
      itemCount: members.length,
      itemBuilder: (context, index) {
        final member = members[index];
        return ListTile(
          leading: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: _getCategoryColor(member.category),
                width: 2.0,
              ),
            ),
            child: CircleAvatar(
              backgroundImage: member.imageUrl != null
                  ? NetworkImage(member.imageUrl!)
                  : const AssetImage('assets/logo_visualonly.jpg')
                      as ImageProvider,
            ),
          ),
          title: Text(member.name ?? 'Unknown'),
          subtitle: Text(member.category ?? ''),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (member.shortNote != null && member.shortNote!.isNotEmpty)
                Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            member.shortNote!,
                            style: TextStyle(
                              color: Colors.grey[300],
                              fontSize: 12,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit, size: 16),
                        onPressed: () => _showShortNoteDialog(
                            context, member, userId, refetch),
                      ),
                    ],
                  ),
                )
              else
                IconButton(
                  icon: const Icon(Icons.edit, size: 16),
                  onPressed: () =>
                      _showShortNoteDialog(context, member, userId, refetch),
                ),
              IconButton(
                icon: Icon(
                  member.favoriteId != null
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: member.favoriteId != null ? Colors.red : Colors.grey,
                ),
                onPressed: () async {
                  final GraphQLClient client =
                      GraphQLProvider.of(context).value;

                  try {
                    if (member.favoriteId != null) {
                      await client.mutate(
                        MutationOptions(
                          document: gql(unmarkFavoriteMutation),
                          variables: {
                            'favoriteId': member.favoriteId,
                          },
                        ),
                      );
                    } else {
                      await client.mutate(
                        MutationOptions(
                          document: gql(markFavoriteMutation),
                          variables: {
                            'targetUserId': member.id,
                            'likedBy': userId,
                          },
                        ),
                      );
                    }
                    refetch?.call();
                  } catch (error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('Failed to update favorite status: $error'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NodeDetailPage(id: member.id),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMapView(List<CommunityMember> members) {
    return CommunityMap(
      members: members,
      currentUser: ref.watch(userProvider),
    );
  }

  Color _getCategoryColor(String? category) {
    switch (category?.toLowerCase()) {
      case 'musician':
        return const Color(0xFFFF7178);
      case 'curator':
        return const Color(0xFFFF692D);
      case 'creator':
        return const Color(0xFFE1F000);
      case 'supporter':
        return const Color(0xFFE4DBC0);
      default:
        return Colors.black;
    }
  }

  // ショートノート編集ダイアログを表示する関数を追加
  Future<void> _showShortNoteDialog(
    BuildContext context,
    CommunityMember member,
    String userId,
    VoidCallback? refetch,
  ) async {
    final controller = TextEditingController(text: member.shortNote);
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
            member.shortNoteId != null ? 'Edit Short Note' : 'Add Short Note'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Enter your short note',
          ),
          maxLength: 50,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text('Save'),
          ),
        ],
      ),
    );

    if (result != null) {
      final GraphQLClient client = GraphQLProvider.of(context).value;
      try {
        if (member.shortNoteId == null) {
          // ショートノートが存在しない場合は追加
          await client.mutate(
            MutationOptions(
              document: gql(addShortNoteMutation),
              variables: {
                'writer': userId,
                'toUser': member.id,
                'comment': result,
              },
            ),
          );
        } else {
          // ショートノートが存在する場合は編集
          await client.mutate(
            MutationOptions(
              document: gql(editShortNoteMutation),
              variables: {
                'shortnoteId': member.shortNoteId,
                'comment': result,
              },
            ),
          );
        }
        refetch?.call();
      } catch (error) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to update short note: $error'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }
}
