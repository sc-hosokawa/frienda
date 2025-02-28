import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/presentation/providers/user_provider.dart';
import 'package:client/presentation/providers/client_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math' show max;
import 'package:client/presentation/widgets/dashboard/balance_screen.dart';
import 'package:client/presentation/widgets/dashboard/product_detail_screen.dart';

class TrackDetailScreen extends ConsumerStatefulWidget {
  final String isrc;
  final String title;
  final String? imageUrl;

  const TrackDetailScreen({
    super.key,
    required this.isrc,
    required this.title,
    this.imageUrl,
  });

  @override
  ConsumerState<TrackDetailScreen> createState() => _TrackDetailScreenState();
}

class _TrackDetailScreenState extends ConsumerState<TrackDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedPeriod = '7';
  Map<String, dynamic>? _chartData;
  bool _isLoading = false;

  final _getTrackInfoQuery = gql('''
    query GetTrackInfo(\$isrc: String!) {
      getTrackInfo(isrc: \$isrc) {
        track {
          isrc
          title
          imgUrl
        }
        product {
          upc
          title
          imgUrl
          type
          artistId
        }
      }
    }
  ''');

  final _getGenderGenRateQuery = gql('''
    query GetGenderGenRateByIsrc(\$artistId: String!, \$userId: String!, \$isrc: String!) {
      getGenderGenRateByIsrc(artistId: \$artistId, userId: \$userId, isrc: \$isrc) {
        genderRate {
          maleCount
          femaleCount
          neutralCount
          unknownCount
        }
        genRate {
          under17
          gen1822
          gen2327
          gen2834
          gen3544
          gen4559
          gen60150
        }
      }
    }
  ''');

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _fetchChartData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _fetchChartData() async {
    setState(() => _isLoading = true);

    try {
      final result = await ref.read(graphQLClientProvider).query(
            QueryOptions(
              document: gql('''
                query GetPlaycountHistory(\$isrc: String!, \$period: Int!) {
                  getPlaycountHistoryByIsrc(isrc: \$isrc, period: \$period) {
                    lineChartData {
                      date
                      spotify
                      apple
                      line
                      amazon
                      youtube
                    }
                  }
                }
              '''),
              variables: {
                'isrc': widget.isrc,
                'period': int.parse(_selectedPeriod),
              },
              fetchPolicy: FetchPolicy.networkOnly,
            ),
          );

      if (result.hasException) {
        throw result.exception!;
      }

      setState(() {
        _chartData = result.data!['getPlaycountHistoryByIsrc'];
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('データの取得に失敗しました: ${e.toString()}')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(widget.title),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'チャート'),
            Tab(text: '傾向'),
          ],
        ),
      ),
      body: Query(
        options: QueryOptions(
          document: _getTrackInfoQuery,
          variables: {'isrc': widget.isrc},
        ),
        builder: (result, {fetchMore, refetch}) {
          if (result.hasException) {
            return Center(child: Text('Error loading track info'));
          }

          if (result.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final trackInfo = result.data!['getTrackInfo'];

          return TabBarView(
            controller: _tabController,
            children: [
              _buildChartTab(trackInfo),
              _buildTrendTab(trackInfo),
            ],
          );
        },
      ),
    );
  }

  Widget _buildChartTab(Map<String, dynamic> trackInfo) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        if (trackInfo['product'] != null) ...[
          const Text('収録作品', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 8),
          _buildProductList(trackInfo['product'] as List),
        ],
        const SizedBox(height: 24),
        _buildLineChartSection(),
      ],
    );
  }

  Widget _buildTrendTab(Map<String, dynamic> trackInfo) {
    final user = ref.watch(userProvider);
    final artistId = (trackInfo['product'] as List).first['artistId'];

    return Query(
      options: QueryOptions(
        document: _getGenderGenRateQuery,
        variables: {
          'isrc': widget.isrc,
          'artistId': artistId,
          'userId': user?.id ?? '',
        },
      ),
      builder: (result, {fetchMore, refetch}) {
        if (result.hasException) {
          return Center(child: Text('Error loading trend data'));
        }

        if (result.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return ProductTrendTab(
          isrc: widget.isrc,
          userId: user?.id ?? '',
          artistId: artistId,
        );
      },
    );
  }

  Widget _buildLineChartSection() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_chartData == null) {
      return const Center(child: Text('データがありません'));
    }

    final chartData = _chartData!['lineChartData'] as List?;
    if (chartData == null || chartData.isEmpty) {
      return const Center(child: Text('データがありません'));
    }

    final spots = chartData.asMap().entries.map((entry) {
      final index = entry.key;
      final data = entry.value;
      final total = (data['spotify'] as int) +
          (data['apple'] as int) +
          (data['line'] as int) +
          (data['amazon'] as int) +
          (data['youtube'] as int);
      return FlSpot(index.toDouble(), total.toDouble());
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Play Count'),
            _buildPeriodDropdown(),
          ],
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 300,
          child: LineChart(
            LineChartData(
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                horizontalInterval: _calculateInterval(spots),
                checkToShowHorizontalLine: (value) => true,
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: Colors.black12,
                    strokeWidth: 1,
                  );
                },
              ),
              backgroundColor: Colors.transparent,
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: _calculateInterval(spots),
                    reservedSize: 60,
                    getTitlesWidget: (value, _) {
                      return SideTitleWidget(
                        axisSide: AxisSide.left,
                        child: Text(
                          value.toInt().toString().replaceAllMapped(
                                RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                (Match m) => '${m[1]},',
                              ),
                          style: const TextStyle(fontSize: 12),
                        ),
                      );
                    },
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    interval:
                        max((chartData.length / 3).floor().toDouble(), 1.0),
                    getTitlesWidget: (value, _) {
                      final index = value.toInt();
                      if (index >= 0 && index < chartData.length) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            chartData[index]['date'],
                            style: const TextStyle(fontSize: 10),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                rightTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: true,
                  color: Colors.blue,
                  barWidth: 2,
                  isStrokeCapRound: true,
                  dotData: FlDotData(show: false),
                  belowBarData: BarAreaData(
                    show: true,
                    color: Colors.blue.withOpacity(0.2),
                  ),
                ),
              ],
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  getTooltipItems: (touchedSpots) {
                    return touchedSpots.map((touchedSpot) {
                      return LineTooltipItem(
                        touchedSpot.y.toInt().toString(),
                        const TextStyle(color: Colors.black),
                      );
                    }).toList();
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  double _calculateInterval(List<FlSpot> spots) {
    if (spots.isEmpty) return 1.0;

    final maxY = spots.map((spot) => spot.y).reduce((a, b) => a > b ? a : b);
    if (maxY <= 0) return 1.0;

    final interval = (maxY / 5).ceil().toDouble();
    return interval > 0 ? interval : 1.0;
  }

  Widget _buildPeriodDropdown() {
    return DropdownButton<String>(
      value: _selectedPeriod,
      onChanged: (String? newValue) {
        if (newValue != null) {
          setState(() {
            _selectedPeriod = newValue;
          });
          _fetchChartData();
        }
      },
      items: [
        DropdownMenuItem(value: '7', child: Text('1週間')),
        DropdownMenuItem(value: '30', child: Text('1ヶ月')),
        DropdownMenuItem(value: '12', child: Text('1年')),
        DropdownMenuItem(value: '36', child: Text('3年')),
        DropdownMenuItem(value: '-1', child: Text('全期間')),
      ],
    );
  }

  Widget _buildProductList(List products) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            child: Container(
              width: 280,
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  if (product['imgUrl'] != null)
                    Image.network(
                      product['imgUrl'],
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    )
                  else
                    Container(
                      width: 80,
                      height: 80,
                      color: Colors.grey,
                      child: const Icon(Icons.music_note),
                    ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          product['title'] ?? 'Unknown',
                          style: Theme.of(context).textTheme.titleMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          product['type'] ?? '',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
