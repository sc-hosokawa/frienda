import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ProductTrendTab extends ConsumerWidget {
  final String? upc;
  final String? isrc;
  final String userId;
  final String artistId;

  const ProductTrendTab({
    super.key,
    this.upc,
    this.isrc,
    required this.userId,
    required this.artistId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // クエリタイプの決定
    String queryType;
    if (upc != null) {
      queryType = 'Upc';
    } else if (isrc != null) {
      queryType = 'Isrc';
    } else {
      queryType = 'Artist';
    }

    return Query(
      options: QueryOptions(
        document: gql('''
          query GetGenderGenRate(\$artistId: String!, \$userId: String!${queryType != 'Artist' ? ', \$${queryType.toLowerCase()}: String!' : ''}) {
            getGenderGenRateBy${queryType}(artistId: \$artistId, userId: \$userId${queryType != 'Artist' ? ', ${queryType.toLowerCase()}: \$${queryType.toLowerCase()}' : ''}) {
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
        '''),
        variables: {
          'artistId': artistId,
          'userId': userId,
          if (upc != null) 'upc': upc,
          if (isrc != null) 'isrc': isrc,
        },
        fetchPolicy: FetchPolicy.networkOnly,
      ),
      builder: (result, {refetch, fetchMore}) {
        if (result.hasException) {
          return Center(child: Text('Error loading data'));
        }

        if (result.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final queryResult = result.data?['getGenderGenRateBy$queryType'];
        final genderRates = queryResult?['genderRate'];
        final generationRates = queryResult?['genRate'];

        return SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16),
              Text(
                '以下のデータは現在Spotifyのデータを利用しています。',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16),
              _buildGenderPlayCountSection(genderRates),
              const SizedBox(height: 20),
              _buildGenerationSection(generationRates),
            ],
          ),
        );
      },
    );
  }

  Widget _buildGenderPlayCountSection(Map<String, dynamic>? genderRates) {
    print('Building gender section with data: $genderRates');
    if (genderRates == null) return const SizedBox.shrink();

    final maleCount = genderRates['maleCount'].toDouble();
    final femaleCount = genderRates['femaleCount'].toDouble();
    final neutralCount = genderRates['neutralCount'].toDouble();
    final unknownCount = genderRates['unknownCount'].toDouble();
    final total = maleCount + femaleCount + neutralCount + unknownCount;

    if (total == 0) {
      return Card(
        color: Colors.grey[850],
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              '算出に必要なデータが収集できませんでした。\n今後十分な再生数がある場合に算出できるようになります。',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    final malePercentage = (maleCount / total * 100).round();
    final femalePercentage = (femaleCount / total * 100).round();
    final neutralPercentage = (neutralCount / total * 100).round();
    final unknownPercentage = (unknownCount / total * 100).round();

    return Card(
      color: Colors.grey[850],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Gender', style: TextStyle(color: Colors.white)),
            const SizedBox(height: 32),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 0,
                  centerSpaceRadius: 60,
                  startDegreeOffset: 270,
                  sections: [
                    PieChartSectionData(
                      color: const Color.fromRGBO(94, 234, 212, 1),
                      value: malePercentage.toDouble(),
                      title: '$malePercentage%',
                      radius: 60,
                      titleStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      color: const Color.fromRGBO(248, 113, 113, 1),
                      value: femalePercentage.toDouble(),
                      title: '$femalePercentage%',
                      radius: 60,
                      titleStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      color: const Color.fromRGBO(147, 197, 253, 1),
                      value: neutralPercentage.toDouble(),
                      title: '$neutralPercentage%',
                      radius: 60,
                      titleStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      color: const Color.fromRGBO(156, 163, 175, 1),
                      value: unknownPercentage.toDouble(),
                      title: '$unknownPercentage%',
                      radius: 60,
                      titleStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildLegend('Male', const Color.fromRGBO(94, 234, 212, 1)),
            const SizedBox(height: 8),
            _buildLegend('Female', const Color.fromRGBO(248, 113, 113, 1)),
            const SizedBox(height: 8),
            _buildLegend('Neutral', const Color.fromRGBO(147, 197, 253, 1)),
            const SizedBox(height: 8),
            _buildLegend('Unknown', const Color.fromRGBO(156, 163, 175, 1)),
          ],
        ),
      ),
    );
  }

  Widget _buildGenerationSection(Map<String, dynamic>? generationRates) {
    print('Building generation section with data: $generationRates');
    if (generationRates == null) return const SizedBox.shrink();

    bool hasNoData = generationRates.values.every((value) => value == 0);

    if (hasNoData) {
      return Card(
        color: Colors.grey[850],
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              '算出に必要なデータが収集できませんでした。\n今後十分な再生数がある場合に算出できるようになります。',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    return Card(
      color: Colors.grey[850],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Generation', style: TextStyle(color: Colors.white)),
            const SizedBox(height: 32),
            _buildGenerationBar(
                'Under 17', generationRates['under17'] ?? 0, Colors.yellow),
            _buildGenerationBar(
                '18-22', generationRates['gen1822'] ?? 0, Colors.pink),
            _buildGenerationBar(
                '23-27', generationRates['gen2327'] ?? 0, Colors.green),
            _buildGenerationBar(
                '28-34', generationRates['gen2834'] ?? 0, Colors.orange),
            _buildGenerationBar(
                '35-44', generationRates['gen3544'] ?? 0, Colors.purple),
            _buildGenerationBar(
                '45-59', generationRates['gen4559'] ?? 0, Colors.blue),
            _buildGenerationBar(
                '60 Over', generationRates['gen60150'] ?? 0, Colors.purple),
          ],
        ),
      ),
    );
  }

  Widget _buildLegend(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          color: color,
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildGenerationBar(String label, int percentage, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(label, style: const TextStyle(color: Colors.white)),
          ),
          Expanded(
            flex: 7,
            child: Stack(
              children: [
                Container(
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: percentage / 100,
                  child: Container(
                    height: 10,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Text('$percentage%',
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.right),
          ),
        ],
      ),
    );
  }
}
