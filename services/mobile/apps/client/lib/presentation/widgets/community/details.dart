import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:client/presentation/providers/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/presentation/widgets/message/message_room.dart';
import 'package:client/presentation/providers/client_provider.dart';
import 'package:intl/intl.dart';
import 'package:client/presentation/widgets/offer/offer_detail.dart';

class NodeDetailPage extends ConsumerStatefulWidget {
  final String id;

  const NodeDetailPage({super.key, required this.id});

  @override
  ConsumerState<NodeDetailPage> createState() => _NodeDetailPageState();
}

class _NodeDetailPageState extends ConsumerState<NodeDetailPage> {
  static final GET_USER_PROFILE = gql('''
    query GetUserProfile(\$viewerId: String!, \$userId: String!) {
      getUserProfile(viewerId: \$viewerId, userId: \$userId) {
        id
        imageUrl
        name
        lastLoggedIn
        xHandle
        instagramHandle
        fbHandle
        shortNote
        greeting
        skill
        connections
        interestOffer
        category
        belongsToArtists
        portfolios {
          id
          title
          description
          imageUrl
          refLink
          createdAt
        }
        offers {
          id
          title
          description
          imageUrl
          fee
          category
        }
      }
    }
  ''');

  static final GET_OTHER_USER_COMMUNITY = gql('''
    query GetOtherUserCommunity(\$viewerId: String!, \$targetUserId: String!) {
      getOtherUserCommunity(viewerId: \$viewerId, targetUserId: \$targetUserId) {
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

  static final CREATE_MESSAGE_ROOM = gql('''
    mutation CreateNewMessageRoom(\$input: CreateNewMessageRoomInput!) {
      createNewMessageRoom(input: \$input) {
        id
      }
    }
  ''');

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);

    return Query(
      options: QueryOptions(
        document: GET_USER_PROFILE,
        variables: {
          'viewerId': user?.id,
          'userId': widget.id,
        },
      ),
      builder: (result, {fetchMore, refetch}) {
        if (result.hasException) {
          return Center(child: Text('Error: ${result.exception.toString()}'));
        }

        if (result.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final profile = result.data?['getUserProfile'];
        if (profile == null) return const Center(child: Text('User not found'));

        return Query(
          options: QueryOptions(
            document: GET_OTHER_USER_COMMUNITY,
            variables: {
              'viewerId': user?.id,
              'targetUserId': widget.id,
            },
          ),
          builder: (communityResult, {fetchMore, refetch}) {
            if (communityResult.hasException) {
              return Center(
                  child:
                      Text('Error: ${communityResult.exception.toString()}'));
            }

            final communityData =
                communityResult.data?['getOtherUserCommunity']?['community'];

            return Scaffold(
              appBar: AppBar(
                title: Text('${profile['name']}'),
                actions: [
                  /*
                  IconButton(
                    icon: const Icon(Icons.share),
                    onPressed: () {
                      // シェア機能の実装
                    },
                  ),
                  */
                  if (user?.id == widget.id)
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        // 編集画面への遷移
                      },
                    )
                  else
                    IconButton(
                      icon: const Icon(Icons.message),
                      onPressed: () async {
                        final currentUserId = ref.read(userProvider)?.id;
                        if (currentUserId == null) return;

                        try {
                          final result =
                              await ref.read(graphQLClientProvider).mutate(
                                    MutationOptions(
                                      document: CREATE_MESSAGE_ROOM,
                                      variables: {
                                        'input': {
                                          'createdBy': currentUserId,
                                          'userList': [
                                            currentUserId,
                                            widget.id
                                          ], // widget.idは表示中のユーザーID
                                          'category': 'dm',
                                        },
                                      },
                                    ),
                                  );

                          if (result.hasException) {
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(result.exception.toString())),
                            );
                            return;
                          }

                          final roomId = result.data?['createNewMessageRoom']
                              ['id'] as String?;

                          if (roomId != null && context.mounted) {
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    MessageRoom(roomId: roomId),
                              ),
                            );

                            // メッセージルームから戻ってきた後にキャッシュをリセット
                            final client = ref.read(graphQLClientProvider);
                            await client.resetStore();
                          }
                        } catch (e) {
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error: $e')),
                          );
                        }
                      },
                    ),
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildHeader(profile),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (profile['greeting'] != null)
                            Text(profile['greeting']),
                          _buildInfoSection(profile),
                          const SizedBox(height: 32),
                          if (profile['offers'] != null)
                            _buildOffersList(profile['offers']),
                          if (communityData != null) ...[
                            const SizedBox(height: 32),
                            _buildCommunityList(
                              communityData,
                              profile['imageUrl'],
                              profile['name'],
                              profile['category'],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildHeader(Map<String, dynamic> profile) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: _getCategoryColor(profile['category']),
                width: 2.0,
              ),
            ),
            child: CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(
                profile['imageUrl'] ?? 'assets/logo_visualonly.jpg',
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (profile['shortNote'] != null) Text(profile['shortNote']),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(Map<String, dynamic> profile) {
    return Column(
      children: [
        // スキル
        _buildInfoRow(
          'スキル',
          profile['skill'] != null && (profile['skill'] as List).isNotEmpty
              ? Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: (profile['skill'] as List<dynamic>).map((skill) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        skill.toString(),
                        style: const TextStyle(fontSize: 12),
                      ),
                    );
                  }).toList(),
                )
              : const Text(
                  '未記入',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
        ),

        const SizedBox(height: 24), // 一定の間隔

        // 属性（カテゴリー）
        _buildInfoRow(
          '属性',
          profile['category'] != null
              ? IntrinsicWidth(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                    ),
                    child: Text(
                      profile['category'].toString(),
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                )
              : const Text(
                  '未記入',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
        ),

        const SizedBox(height: 24), // 一定の間隔

        // 興味のあるオファー
        _buildInfoRow(
          '興味のあるオファー',
          profile['interestOffer'] != null
              ? Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    profile['interestOffer'].toString(),
                    style: const TextStyle(fontSize: 12),
                  ),
                )
              : const Text(
                  '未記入',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
        ),

        const SizedBox(height: 24), // 一定の間隔

        // 所属するアーティスト
        _buildInfoRow(
          '所属するArtists',
          profile['belongsToArtists'] != null &&
                  (profile['belongsToArtists'] as List).isNotEmpty
              ? Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: (profile['belongsToArtists'] as List<dynamic>)
                      .map((artist) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6,
                      ),
                      child: Text(
                        artist.toString(),
                        style: const TextStyle(fontSize: 12),
                      ),
                    );
                  }).toList(),
                )
              : const Text(
                  '未記入',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, Widget content) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 140,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 24),
        Expanded(child: content),
      ],
    );
  }

  Widget _buildOffersList(List<dynamic> offers) {
    if (offers.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'オファー',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: offers.map((offer) {
              return Container(
                width: 280,
                margin: const EdgeInsets.only(right: 16),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OfferDetailPage(
                          offerId: offer['id'],
                        ),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (offer['imageUrl'] != null)
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12)),
                            child: Image.network(
                              offer['imageUrl'],
                              height: 160,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                offer['title'] ?? '',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                offer['description'] ?? '',
                                style: const TextStyle(fontSize: 12),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                              if (offer['fee'] != null) ...[
                                const SizedBox(height: 8),
                                Text(
                                  '${NumberFormat('#,###').format(offer['fee'])} FSP',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                              if (offer['category'] != null) ...[
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    offer['category'],
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildCommunityList(
    List<dynamic> community,
    String? centerUserImage,
    String? centerUserName,
    String? centerUserCategory,
  ) {
    // 自分のユーザーIDを取得
    final currentUserId = ref.read(userProvider)?.id;

    // 自分以外のユーザーをフィルタリング
    final filteredCommunity =
        community.where((member) => member['id'] != currentUserId).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            '繋がりのあるユーザー',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: filteredCommunity.length, // フィルタリングされたリストを使用
          itemBuilder: (context, index) {
            final member = filteredCommunity[index]; // フィルタリングされたリ��トを使用
            return ListTile(
              leading: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _getCategoryColor(member['category']),
                    width: 2.0,
                  ),
                ),
                child: CircleAvatar(
                  backgroundImage: member['imageUrl'] != null
                      ? NetworkImage(member['imageUrl'])
                      : const AssetImage('assets/logo_visualonly.jpg')
                          as ImageProvider,
                ),
              ),
              title: Text(member['name'] ?? 'Unknown'),
              subtitle: Text(member['category'] ?? ''),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (member['shortNote'] != null &&
                      member['shortNote'].isNotEmpty)
                    Flexible(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Text(
                                member['shortNote'],
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
                              context,
                              member,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    IconButton(
                      icon: const Icon(Icons.edit, size: 16),
                      onPressed: () => _showShortNoteDialog(
                        context,
                        member,
                      ),
                    ),
                  IconButton(
                    icon: Icon(
                      member['favoriteId'] != null
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: member['favoriteId'] != null
                          ? Colors.red
                          : Colors.grey,
                      size: 20,
                    ),
                    onPressed: () async {
                      final userId = ref.read(userProvider)?.id;
                      if (userId == null) return;

                      final GraphQLClient client =
                          GraphQLProvider.of(context).value;
                      try {
                        if (member['favoriteId'] != null) {
                          await client.mutate(
                            MutationOptions(
                              document: gql('''
                                mutation UnmarkFavorite(\$favoriteId: String!) {
                                  unmarkFavorite(favoriteId: \$favoriteId) {
                                    id
                                  }
                                }
                              '''),
                              variables: {
                                'favoriteId': member['favoriteId'],
                              },
                            ),
                          );
                        } else {
                          await client.mutate(
                            MutationOptions(
                              document: gql('''
                                mutation MarkFavorite(\$targetUserId: String!, \$likedBy: String!) {
                                  markFavorite(targetUserId: \$targetUserId, likedBy: \$likedBy) {
                                    id
                                  }
                                }
                              '''),
                              variables: {
                                'targetUserId': member['id'],
                                'likedBy': userId,
                              },
                            ),
                          );
                        }
                        // キャッシュをリセットして再取得
                        await client.resetStore();
                      } catch (error) {
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Failed to update favorite status: $error'),
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
                  builder: (context) => NodeDetailPage(id: member['id']),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  // ショートノート編集ダイアログを表示する関数を追加
  Future<void> _showShortNoteDialog(
    BuildContext context,
    Map<String, dynamic> member,
  ) async {
    final controller = TextEditingController(text: member['shortNote']);
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(member['shortNoteId'] != null
            ? 'Edit Short Note'
            : 'Add Short Note'),
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
      final userId = ref.read(userProvider)?.id;
      if (userId == null) return;

      final GraphQLClient client = GraphQLProvider.of(context).value;
      try {
        if (member['shortNoteId'] == null) {
          // ショートノートが存在しない場合は追加
          await client.mutate(
            MutationOptions(
              document: gql('''
                mutation AddShortNote(\$writer: String!, \$toUser: String!, \$comment: String!) {
                  addShortnote(writer: \$writer, toUser: \$toUser, comment: \$comment) {
                    id
                  }
                }
              '''),
              variables: {
                'writer': userId,
                'toUser': member['id'],
                'comment': result,
              },
            ),
          );
        } else {
          // ショートノートが存在する場合は編集
          await client.mutate(
            MutationOptions(
              document: gql('''
                mutation EditShortNote(\$shortnoteId: String!, \$comment: String!) {
                  editShortnote(shortnoteId: \$shortnoteId, comment: \$comment) {
                    id
                  }
                }
              '''),
              variables: {
                'shortnoteId': member['shortNoteId'],
                'comment': result,
              },
            ),
          );
        }
        // キャッシュをリセットして再取得
        await client.resetStore();
      } catch (error) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update short note: $error'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
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
}
