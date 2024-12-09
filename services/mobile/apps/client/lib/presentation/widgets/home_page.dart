import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/presentation/providers/client_provider.dart';
import 'package:client/presentation/providers/auth_provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:client/presentation/providers/user_provider.dart';
import 'package:graphql/client.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/number_symbols_data.dart';
import 'package:contentful_flutter/contentful_flutter.dart';
import 'package:client/presentation/widgets/news/detail.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _isLoading = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _isLoading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: PageStorageKey('home_page'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildActionsSection(),
          const SizedBox(height: 24),
          _buildNewsSection(),
          /*
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: const Divider(
              height: 1,
              thickness: 1,
              color: Color.fromARGB(255, 50, 50, 50),
            ),
          ),
          */
          // const SizedBox(height: 4),
          // _buildTrendingSection(),
          // const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildActionsSection() {
    final userState = ref.watch(userProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Text('Actions', style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ),
        Query(
          options: QueryOptions(
            document: gql('''
            query GetQuests(\$userId: String!) {
              getQuestByUserId(userId: \$userId) {
                id
                name
                description
                category
              }
            }
          '''),
            variables: {
              'userId': userState?.id ?? '',
            },
            fetchPolicy: FetchPolicy.networkOnly,
          ),
          builder: (result, {refetch, fetchMore}) {
            if (result.hasException) {
              return Center(child: Text('Error loading quests'));
            }

            if (result.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            final quests =
                result.data?['getQuestByUserId'] as List<dynamic>? ?? [];

            if (quests.isEmpty) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Text('No quests available'),
                ),
              );
            }

            return SizedBox(
              height: 140,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: quests.length,
                itemBuilder: (context, index) {
                  final quest = quests[index];
                  return Card(
                    margin: EdgeInsets.only(
                      left: 16,
                      right: index == quests.length - 1 ? 16 : 0,
                    ),
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: const BorderSide(
                        color: Color(0xFF707070),
                        width: 1,
                      ),
                    ),
                    child: Container(
                      width: 240,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              quest['category']?.toString() ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            quest['name'] ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            quest['description'] ?? '',
                            style: Theme.of(context).textTheme.bodySmall,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildNewsSection() {
    const repository = ContentfulDeliveryAPIRepository(
      client: ContentfulClient(
        spaceId: 'ihpc1xwibnxu',
        accessToken: 'YWRJHfNEmCWVL126zO-UHS-lKwx1oUBstPw5X8KtOxs',
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/news.svg',
                width: 20,
                height: 20,
              ),
              const SizedBox(width: 8),
              Text('News', style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ),
        SizedBox(
          height: 300,
          child: FutureBuilder(
            future: repository.getEntries<Entry<dynamic>>(
              fromJsonT: (json) => Entry.fromJson(
                json as Map<String, dynamic>,
                (fields) => fields as Map<String, dynamic>,
              ),
              query: {
                'include': '10',
              },
            ),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final data =
                  snapshot.data as ContentfulDeliveryDataModel<Entry<dynamic>>;
              final newsItems = data.items;

              // 各記事のサムネイルURLを取得
              for (final newsItem in newsItems) {
                final thumbnailSys = newsItem.fields['thumbnail']['sys'];
                final imageUrl = repository.getAssetUrlFromSys(
                  sys: Sys.fromJson(thumbnailSys),
                  includes: data.includes,
                );
              }

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: newsItems.length,
                itemBuilder: (context, index) {
                  final newsItem = newsItems[index];
                  final thumbnailSys = newsItem.fields['thumbnail']['sys'];
                  final imageUrl = repository.getAssetUrlFromSys(
                    sys: Sys.fromJson(thumbnailSys),
                    includes: data.includes,
                  );

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsDetailPage(),
                          settings: RouteSettings(
                            arguments: {
                              'id': newsItem.sys?.id,
                              'title': newsItem.fields['title']?.toString(),
                              'body': newsItem.fields['body'],
                              'imageUrl': imageUrl,
                              'category':
                                  newsItem.fields['category']?.toString(),
                              'date': newsItem.fields['date']?.toString(),
                            },
                          ),
                        ),
                      );
                    },
                    child: Card(
                      margin: EdgeInsets.only(
                        left: 16,
                        right: index == newsItems.length - 1 ? 16 : 0,
                      ),
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: const BorderSide(
                          color: Color(0xFF707070),
                          width: 1,
                        ),
                      ),
                      child: Container(
                        width: 360,
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 180,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: imageUrl != null
                                    ? DecorationImage(
                                        image: NetworkImage(imageUrl),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                                color: Colors.grey[300],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: _getCategoryColor(newsItem
                                            .fields['category']
                                            ?.toString() ??
                                        '')
                                    .withOpacity(0.8),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                newsItem.fields['category']
                                        ?.toString()
                                        ?.toUpperCase() ??
                                    '',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w100,
                                    ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              newsItem.fields['title']?.toString() ??
                                  'No Title',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              newsItem.fields['date'] != null
                                  ? DateFormat('yyyy/MM/dd HH:mm').format(
                                      DateTime.parse(newsItem.fields['date']
                                              .toString())
                                          .toLocal())
                                  : '',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTrendingSection() {
    final userState = ref.watch(userProvider);

    if (userState == null || userState.belongsToArtists.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Text('アーティストに所属していません'),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/dashboard.svg',
                width: 20,
                height: 20,
              ),
              const SizedBox(width: 8),
              Text('Trending', style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ),
        Query(
          options: QueryOptions(
            document: gql('''
              query GetTrending(\$artistId: String!, \$userId: String!) {
                getTrending(artistId: \$artistId, userId: \$userId) {
                  trendingTracks {
                    isrc
                    trackTitle
                    upcTitle
                    imageUrl
                    totalPlayCount
                    weeklyPlayCount
                  }
                }
              }
            '''),
            variables: {
              'artistId': userState.belongsToArtists[0].artistId,
              'userId': userState.id,
            },
            fetchPolicy: FetchPolicy.networkOnly,
          ),
          builder: (result, {refetch, fetchMore}) {
            if (result.hasException) {
              return Center(child: Text('Error loading trending data'));
            }

            if (result.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            final tracks = result.data?['getTrending']?['trendingTracks']
                    as List<dynamic>? ??
                [];

            if (tracks.isEmpty) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Text('トレンドデータが�りません'),
                ),
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: tracks.length,
              itemBuilder: (context, index) {
                final track = tracks[index];
                return _buildTrendingItem(
                  index,
                  track['trackTitle'] ?? 'Unknown Track',
                  track['imageUrl'],
                  track['totalPlayCount'] ?? 0,
                  track['weeklyPlayCount'] ?? 0,
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildTrendingItem(int index, String title, String? imageUrl,
      int totalCount, int weeklyCount) {
    final rank = index + 1;
    final numberFormat = NumberFormat('#,###');

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          SizedBox(
            width: 30,
            child: Text(
              '$rank',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              image: imageUrl != null
                  ? DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: imageUrl == null ? const Icon(Icons.music_note) : null,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Total: ${numberFormat.format(totalCount)}',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                'Week: ${numberFormat.format(weeklyCount)}',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category.toUpperCase()) {
      case 'INFO':
        return Color(0xFFB487FF); // 薄い紫 (#E6B3FF)
      case 'FRIENDSHIP. DAO':
        return Color(0xFF00B496); // 薄い緑 (#B3FFB3)
      case 'FRIENDSHIP.':
        return Color(0xFF2D78FF); // 薄い青 (#B3E0FF)
      default:
        return Theme.of(context).colorScheme.primary;
    }
  }
}
