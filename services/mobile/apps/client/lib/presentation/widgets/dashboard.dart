import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:client/presentation/widgets/components/artist_select_sheet.dart';
import 'package:client/presentation/widgets/dashboard/new_artists.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/presentation/providers/user_provider.dart';
import 'package:client/presentation/providers/client_provider.dart';
import 'package:gql_link/gql_link.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:client/presentation/widgets/dashboard/all_track_screen.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({super.key});

  @override
  ConsumerState<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  late String? _selectedArtist;
  Map<String, dynamic>? _overviewData;
  bool _isLoading = false;

  static const _gridColor = Color(0xffe7e8ec);
  static const _borderColor = Color(0xff37434d);
  static const _textColor = Color(0xff67727d);

  LineChartData _createChartData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (_) => FlLine(
          color: _gridColor,
          strokeWidth: 0.5,
        ),
      ),
      titlesData: FlTitlesData(
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: (value, _) => Text(
              value.toInt().toString(),
              style: const TextStyle(
                color: _textColor,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 22,
            interval: 1,
            getTitlesWidget: (value, _) {
              // データポイントに合わせてラベルを設定
              switch (value.toInt()) {
                case 0:
                  return _buildBottomTitleWidget('Day 1');
                case 2:
                  return _buildBottomTitleWidget('Day 2');
                case 4:
                  return _buildBottomTitleWidget('Day 3');
                case 6:
                  return _buildBottomTitleWidget('Day 4');
                case 8:
                  return _buildBottomTitleWidget('Day 5');
                case 10:
                  return _buildBottomTitleWidget('Day 6');
                default:
                  return const SizedBox.shrink();
              }
            },
          ),
        ),
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          left: BorderSide(color: _borderColor, width: 1),
          bottom: BorderSide(color: _borderColor, width: 1),
        ),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
          ],
          isCurved: true,
          color: Colors.green,
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            color: Colors.green.withOpacity(0.3),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomTitleWidget(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: _textColor,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
    );
  }

  void _showArtistSelectionBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) => _buildBottomSheetContent(context),
    );
  }

  Widget _buildBottomSheetContent(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Column(
        children: [
          Expanded(
            child: _ArtistList(onSelectArtist: _selectArtist),
          ),
          _AddNewArtistButton(
            onArtistsAdded: (List<String> newArtists) {
              setState(() {
                // ここで新しいアーティストを追加する処理を実装
                // 例: _artists.addAll(newArtists);
              });
            },
          ),
        ],
      ),
    );
  }

  void _selectArtist(String artist) {
    setState(() {
      _selectedArtist = artist;
    });
    Navigator.pop(context);
    _fetchOverviewData();
  }

  @override
  void initState() {
    super.initState();
    final userRef = ProviderContainer().read(userProvider);
    _selectedArtist = userRef?.belongsToArtists.firstOrNull?.name;
    _fetchOverviewData();
  }

  @override
  Widget build(BuildContext context) {
    // アーティストが選択されていない場合の表示
    if (_selectedArtist == null || _selectedArtist!.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'アーティストを選択してください',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _showArtistSelectionBottomSheet,
              child: const Text('アーティストを選択'),
            ),
          ],
        ),
      );
    }

    // 通常のダッシュボード表示
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildArtistSelector(),
            const SizedBox(height: 20),
            _buildStatsSection(),
            const SizedBox(height: 20),
            _buildTrendingSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildArtistSelector() {
    return GestureDetector(
      onTap: _showArtistSelectionBottomSheet,
      child: Row(
        children: [
          const SizedBox(width: 8),
          Text(
            _selectedArtist!,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(width: 4),
          const Icon(Icons.arrow_drop_down),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final totalPlays = _overviewData?['totalPlaybacks'] ?? 0;
    final weeklyPlays = _overviewData?['weeklyPlaybacks'] ?? 0;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatItem('Song Played',
                  NumberFormat('#,###').format(totalPlays), 'Total'),
              const VerticalDivider(thickness: 2, width: 1, color: Colors.grey),
              _buildStatItem('Song Played',
                  NumberFormat('#,###').format(weeklyPlays), 'Week'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String title, String value, String subtitle) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (subtitle.isNotEmpty) ...[
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 10,
                color: Colors.grey,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTrendingSection() {
    final userState = ref.watch(userProvider);

    if (_selectedArtist == null) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Trending', style: Theme.of(context).textTheme.titleMedium),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AllTracksScreen(
                      artistId: userState?.belongsToArtists
                              .firstWhere(
                                (artist) => artist.name == _selectedArtist,
                                orElse: () =>
                                    throw Exception('Artist not found'),
                              )
                              .artistId ??
                          '',
                      artistName: _selectedArtist ?? '',
                    ),
                  ),
                );
              },
              child: const Text('全ての作品を見る'),
            ),
          ],
        ),
        const SizedBox(height: 10),
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
              'artistId': userState?.belongsToArtists
                  .firstWhere(
                    (artist) => artist.name == _selectedArtist,
                    orElse: () => throw Exception('Artist not found'),
                  )
                  .artistId,
              'userId': userState?.id ?? '',
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
                  child: Text('No trending tracks available'),
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
      padding: const EdgeInsets.symmetric(vertical: 8.0),
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

  Future<void> _fetchOverviewData() async {
    if (_selectedArtist == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final user = ref.read(userProvider);
      if (user == null) {
        throw Exception('User data not found');
      }

      final selectedArtistData = user.belongsToArtists.firstWhere(
          (artist) => artist.name == _selectedArtist,
          orElse: () => throw Exception('Artist not found'));

      if (selectedArtistData.artistId.isEmpty) {
        throw Exception('Invalid artist ID');
      }

      final result = await ref.read(graphQLClientProvider).query(
            QueryOptions(
              document: gql('''
                query GetOverview(\$artistId: String!, \$userId: String!) {
                  getOverview(artistId: \$artistId, userId: \$userId) {
                    totalPlaybacks
                    weeklyPlaybacks
                  }
                }
              '''),
              variables: {
                'artistId': selectedArtistData.artistId,
                'userId': user.id,
              },
            ),
          );

      if (result.hasException) {
        throw result.exception!;
      }

      setState(() {
        _overviewData = result.data?['getOverview'];
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('データの取得に失敗しました: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}

class _ArtistList extends ConsumerWidget {
  final Function(String) onSelectArtist;

  const _ArtistList({super.key, required this.onSelectArtist});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(userProvider);
    final artists = userData?.belongsToArtists ?? [];

    return ListView(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Center(
            child: Text('選択可能なアーティスト', style: TextStyle(fontSize: 16)),
          ),
        ),
        if (artists.isEmpty)
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Text('閲覧可能なアーティストがありません'),
            ),
          )
        else
          for (final artist in artists)
            _ArtistListTile(
              artist: artist.name,
              imageUrl: artist.imageUrl,
              onTap: () => onSelectArtist(artist.name),
            ),
      ],
    );
  }
}

class _ArtistListTile extends StatelessWidget {
  final String artist;
  final String? imageUrl;
  final VoidCallback onTap;

  const _ArtistListTile({
    super.key,
    required this.artist,
    this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(artist),
      onTap: onTap,
    );
  }
}

class _AddNewArtistButton extends StatelessWidget {
  final Function(List<String>) onArtistsAdded;

  const _AddNewArtistButton({super.key, required this.onArtistsAdded});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () async {
          final result = await Navigator.of(context).push<List<String>>(
            MaterialPageRoute(
              builder: (context) => const NewArtists(),
            ),
          );
          if (result != null && result.isNotEmpty) {
            onArtistsAdded(result);
          }
          Navigator.pop(context); // Close the bottom sheet
        },
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add),
              SizedBox(width: 4),
              Text('アーティストデータの閲覧権限を申請する'),
            ],
          ),
        ),
      ),
    );
  }
}
