import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ProductTrendTab extends ConsumerWidget {
  final String upc;
  final String userId;
  final String artistId;

  const ProductTrendTab({
    super.key,
    required this.upc,
    required this.userId,
    required this.artistId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Query(
      options: QueryOptions(
        document: gql('''
          query GetGenderGenRate(\$artistId: String!, \$userId: String!) {
            getGenderGenRateByArtist(artistId: \$artistId, userId: \$userId) {
              genderRate {
                maleCount
                femaleCount
              }
              genRate {
                under14
                gen1519
                gen2024
                gen2529
                gen3034
                gen3539
                gen4044
                gen4549
                gen50Over
              }
            }
          }
        '''),
        variables: {
          'artistId': artistId,
          'userId': userId,
        },
        fetchPolicy: FetchPolicy.networkOnly,
      ),
      builder: (result, {refetch, fetchMore}) {
        print('Query result: ${result.data}');
        print('Has exception: ${result.hasException}');
        if (result.hasException) {
          print('Exception details: ${result.exception}');
        }

        if (result.hasException) {
          return Center(child: Text('Error loading data'));
        }

        if (result.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final genderRates =
            result.data?['getGenderGenRateByArtist']?['genderRate'];
        final generationRates =
            result.data?['getGenderGenRateByArtist']?['genRate'];

        print('Gender rates: $genderRates');
        print('Generation rates: $generationRates');

        return SingleChildScrollView(
          child: Column(
            children: [
              Text(
                '以下のデータは現在LINE Musicのデータを利用しています。今後、他のDSPのデータも統合予定です。',
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
    final total = maleCount + femaleCount;

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
                      color: const Color.fromRGBO(94, 234, 212, 0.6),
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
                      color: const Color.fromRGBO(248, 113, 113, 0.6),
                      value: femalePercentage.toDouble(),
                      title: '$femalePercentage%',
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
            _buildLegend('Male', const Color.fromRGBO(94, 234, 212, 0.6)),
            const SizedBox(height: 8),
            _buildLegend('Female', const Color.fromRGBO(248, 113, 113, 0.6)),
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
                'Under 14', generationRates['under14'] ?? 0, Colors.yellow),
            _buildGenerationBar(
                '15-19', generationRates['gen1519'] ?? 0, Colors.pink),
            _buildGenerationBar(
                '20-24', generationRates['gen2024'] ?? 0, Colors.green),
            _buildGenerationBar(
                '25-29', generationRates['gen2529'] ?? 0, Colors.orange),
            _buildGenerationBar(
                '30-34', generationRates['gen3034'] ?? 0, Colors.purple),
            _buildGenerationBar(
                '35-39', generationRates['gen3539'] ?? 0, Colors.blue),
            _buildGenerationBar(
                '40-44', generationRates['gen4044'] ?? 0, Colors.teal),
            _buildGenerationBar(
                '45-49', generationRates['gen4549'] ?? 0, Colors.pink),
            _buildGenerationBar(
                '50 Over', generationRates['gen50Over'] ?? 0, Colors.purple),
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
