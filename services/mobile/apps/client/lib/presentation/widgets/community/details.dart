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
        shortNoteId
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

  static const String reportUserMutation = '''
    mutation ReportUser(\$input: ReportUserInput!) {
      reportUser(input: \$input) {
        id
      }
    }
  ''';

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
                  if (user?.id == widget.id)
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        // 編集画面への遷移
                      },
                    )
                  else
                    Row(
                      children: [
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
                                      content:
                                          Text(result.exception.toString())),
                                );
                                return;
                              }

                              final roomId =
                                  result.data?['createNewMessageRoom']['id']
                                      as String?;

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
                        PopupMenuButton<String>(
                          icon: Icon(Icons.more_vert),
                          onSelected: (value) {
                            if (value == 'report') {
                              _showReportDialog(widget.id);
                            } else if (value == 'block') {
                              _showBlockConfirmationDialog(widget.id);
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
                                  Icon(Icons.block,
                                      color: Colors.red, size: 20),
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
                          const SizedBox(height: 32),
                          _buildInfoSection(profile),
                          const SizedBox(height: 32),
                          if (profile['offers'] != null)
                            _buildOffersList(profile['offers']),
                        ],
                      ),
                    ),
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
            );
          },
        );
      },
    );
  }

  Widget _buildHeader(Map<String, dynamic> profile) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
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
                  backgroundImage: profile['imageUrl'] != null
                      ? NetworkImage(profile['imageUrl'])
                      : const AssetImage('assets/logo_visualonly.jpg')
                          as ImageProvider,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [],
                ),
              ),
            ],
          ),
          if (ref.read(userProvider)?.id != widget.id) ...[
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton.icon(
                  icon: const Icon(Icons.edit, size: 16),
                  label: Text(
                    profile['shortNote'] == null || profile['shortNote'].isEmpty
                        ? 'ショートノートを編集'
                        : profile['shortNote'],
                  ),
                  onPressed: () => _showShortNoteDialog(context, profile, null),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoSection(Map<String, dynamic> profile) {
    return Column(
      children: [
        _buildInfoRow(
          'スキル',
          profile['skill'] != null
              ? Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: (profile['skill'] is List
                          ? profile['skill'] as List<dynamic>
                          : [profile['skill']])
                      .map((skill) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6,
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

        const SizedBox(height: 24),

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
                    vertical: 6,
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

        const SizedBox(height: 24),

        _buildInfoRow(
          '所属するArtists',
          profile['belongsToArtists'] != null
              ? Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: (profile['belongsToArtists'] is List
                          ? profile['belongsToArtists'] as List<dynamic>
                          : [profile['belongsToArtists']])
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
                          )
                        else
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12)),
                            child: Image.asset(
                              'assets/logo_visualonly.jpg',
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
                              SizedBox(
                                height: 54, // 3行分の高さ (18px × 3)
                                child: Text(
                                  offer['description'] ?? '',
                                  style: const TextStyle(fontSize: 12),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
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
    final currentUserId = ref.read(userProvider)?.id;
    final filteredCommunity =
        community.where((member) => member['id'] != currentUserId).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
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
          itemCount: filteredCommunity.length,
          itemBuilder: (context, index) {
            final member = filteredCommunity[index];
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
              trailing: IconButton(
                icon: Icon(
                  member['favoriteId'] != null
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color:
                      member['favoriteId'] != null ? Colors.red : Colors.grey,
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
                    if (!mounted) return;
                    await client.resetStore();
                  } catch (error) {
                    if (!mounted) return;
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

  // ショートノート編集用のダイアログを表示する関数
  Future<void> _showShortNoteDialog(BuildContext context,
      Map<String, dynamic> profile, Function? refetch) async {
    final controller = TextEditingController(text: profile['shortNote']);
    print('shortnoteid= ${profile['shortNoteId']}');
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title:
            Text(profile['shortNoteId'] != null ? 'ショートノートを編集' : 'ショートノートを追加'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'ショートノートを入力',
          ),
          maxLength: 50,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text('保存'),
          ),
        ],
      ),
    );

    if (result != null) {
      final currentUserId = ref.read(userProvider)?.id;
      if (currentUserId == null) return;

      final client = ref.read(graphQLClientProvider);
      try {
        if (profile['shortNoteId'] == null) {
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
                'writer': currentUserId,
                'toUser': widget.id,
                'comment': result,
              },
            ),
          );
        } else {
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
                'shortnoteId': profile['shortNoteId'],
                'comment': result,
              },
            ),
          );
        }
        // キャッシュをクリアしてデータを再取得
        await client.resetStore();
        // ページを更新
        refetch?.call();
      } catch (error) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('ショートノートの更新に失敗しました: $error'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
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
                // まずダイアログを閉じてから報告処理を実行
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
      final currentUser = ref.read(userProvider);
      if (currentUser?.id == null) return;

      final result = await ref.read(graphQLClientProvider).mutate(
            MutationOptions(
              document: gql(reportUserMutation),
              variables: {
                'input': {
                  'reportedUserId': targetUserId,
                  'reporterUserId': currentUser!.id,
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
      final userId = ref.read(userProvider)?.id;
      if (userId == null) return;

      final GraphQLClient client = GraphQLProvider.of(context).value;
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
