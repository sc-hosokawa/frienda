import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/presentation/providers/client_provider.dart';
import 'package:client/presentation/providers/user_provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:client/presentation/widgets/dashboard/balance_screen.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final String title;
  final String upc;
  final String artistId;
  final List<dynamic> tracks;

  const ProductDetailScreen({
    super.key,
    required this.title,
    required this.upc,
    required this.artistId,
    required this.tracks,
  });

  @override
  ConsumerState<ProductDetailScreen> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen>
    with SingleTickerProviderStateMixin {
  String _selectedPeriod = '12';
  Map<String, dynamic>? _chartData;
  bool _isLoading = false;
  late TabController _tabController;
  late final String? userId;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    userId = ref.read(userProvider)?.id;
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
      print(
          'Fetching chart data for UPC: ${widget.upc}, Period: $_selectedPeriod');

      final result = await ref.read(graphQLClientProvider).query(
            QueryOptions(
              document: gql('''
                query GetPlaycountHistory(\$upc: String!, \$period: Int!) {
                  getPlaycountHistoryByUpc(upc: \$upc, period: \$period) {
                    lineChartData {
                      date
                      trackCount
                    }
                  }
                }
              '''),
              variables: {
                'upc': widget.upc,
                'period': int.parse(_selectedPeriod),
              },
              fetchPolicy: FetchPolicy.networkOnly,
            ),
          );

      print('PlaycountHistory Response: ${result.data}');

      if (result.hasException) {
        throw result.exception!;
      }

      if (result.data == null ||
          result.data!['getPlaycountHistoryByUpc'] == null) {
        throw Exception('No data received from the server');
      }

      setState(() {
        _chartData = result.data!['getPlaycountHistoryByUpc'];
      });

      print('Updated Chart Data: $_chartData');
    } catch (e) {
      print('Error fetching chart data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('データの取得に失敗しました: ${e.toString()}')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
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
      final trackCount = (data['trackCount'] as Map<String, dynamic>)
          .values
          .fold<int>(0, (sum, count) => sum + (count as int));
      return FlSpot(index.toDouble(), trackCount.toDouble());
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
                    interval: (chartData.length / 3).floor().toDouble(),
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
    if (spots.isEmpty) return 1;
    final maxY = spots.map((spot) => spot.y).reduce((a, b) => a > b ? a : b);
    return (maxY / 5).ceil().toDouble();
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

  Widget _buildTrackList() {
    if (_chartData == null ||
        _chartData!['lineChartData'] == null ||
        (_chartData!['lineChartData'] as List).isEmpty) {
      return const SizedBox.shrink();
    }

    // 期間内の各楽曲の合計再生数を計算
    final chartData = _chartData!['lineChartData'] as List;
    final Map<String, int> totalPlayCounts = {};

    for (final track in widget.tracks) {
      final title = track['title'] as String;
      int total = 0;

      for (final dayData in chartData) {
        final trackCount =
            (dayData['trackCount'] as Map<String, dynamic>)[title] as int? ?? 0;
        total += trackCount;
      }

      totalPlayCounts[title] = total;
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.tracks.length,
      itemBuilder: (context, index) {
        final track = widget.tracks[index];
        final title = track['title'] ?? 'Unknown Track';
        final totalPlayCount =
            totalPlayCounts[title]?.toString().replaceAllMapped(
                      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                      (Match m) => '${m[1]},',
                    ) ??
                '0';

        return ListTile(
          title: Text(title),
          subtitle: Text(
            track['isrc'] ?? 'N/A',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
          trailing: Text(
            totalPlayCount,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'チャート'),
            Tab(text: '傾向'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              _buildLineChartSection(),
              const SizedBox(height: 20),
              _buildTrackList(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ProductTrendTab(
              upc: widget.upc,
              userId: userId ?? '',
              artistId: widget.artistId,
            ),
          ),
        ],
      ),
    );
  }
}
