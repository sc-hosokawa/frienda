import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:client/presentation/widgets/components/artist_select_sheet.dart';
import 'package:client/presentation/widgets/dashboard/new_artists.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/presentation/providers/user_provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late String? _selectedArtist;
  String _selectedSong = 'Song 1';
  String _selectedPeriod = '1week';
  String _selectedWork = 'UPC 1';
  String _selectedDSP = 'All';

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
  }

  @override
  void initState() {
    super.initState();
    // Initialize _selectedArtist with the first artist from the user provider
    final userRef = ProviderContainer().read(userProvider);
    _selectedArtist = userRef?.belongsToArtists.firstOrNull?.name;
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
            const SizedBox(height: 20),
            _buildLineChartSection(),
            const SizedBox(height: 20),
            _buildGenderPlayCountSection(),
            const SizedBox(height: 20),
            _buildGenerationSection(),
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
          const CircleAvatar(
            radius: 16,
            backgroundColor: Color(0xFFE0E0E0),
            child: Icon(Icons.person, size: 20, color: Color(0xFF616161)),
          ),
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
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatItem('Song Played', '1,234,567', 'Total'),
              const VerticalDivider(thickness: 2, width: 1, color: Colors.grey),
              _buildStatItem('Song Played', '98,765', 'Week'),
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

  Widget _buildLineChartSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildWorkDropdown(),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Play Count'),
            Row(
              children: [
                _buildSongDropdown(),
                const SizedBox(width: 16),
                _buildPeriodDropdown(),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        _buildDSPSelector(),
        const SizedBox(height: 20),
        AspectRatio(
          aspectRatio: 1.5,
          child: LineChart(_createChartData()),
        ),
      ],
    );
  }

  Widget _buildDSPSelector() {
    List<String> dsps = [
      'All',
      'Spotify',
      'Apple Music',
      'YouTube Music',
      'Amazon Music',
      'LINE MUSIC',
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: dsps.map((dsp) => _buildDSPChip(dsp)).toList(),
      ),
    );
  }

  Widget _buildDSPChip(String dsp) {
    bool isSelected = _selectedDSP == dsp;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: FilterChip(
        label: Text(dsp),
        selected: isSelected,
        onSelected: (bool selected) {
          if (!isSelected) {
            setState(() {
              _selectedDSP = dsp;
            });
          }
        },
        showCheckmark: false,
        backgroundColor: Colors.grey[500],
        selectedColor: Colors.green,
        labelStyle: TextStyle(
          color: Colors.black,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }

  Widget _buildWorkDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('作品選択', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 4),
        DropdownButton<String>(
          value: _selectedWork,
          isExpanded: true,
          onChanged: (String? newValue) {
            setState(() {
              _selectedWork = newValue!;
              // ここで作品が変更されたときの処理を追加
              // 例: データの再取得やグラフの更新など
            });
          },
          items: <String>['UPC 1', 'UPC 2', 'UPC 3', 'UPC 4']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSongDropdown() {
    return DropdownButton<String>(
      value: _selectedSong,
      onChanged: (String? newValue) {
        setState(() {
          _selectedSong = newValue!;
        });
      },
      items: <String>['Song 1', 'Song 2', 'Song 3', 'Song 4']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget _buildPeriodDropdown() {
    return DropdownButton<String>(
      value: _selectedPeriod,
      onChanged: (String? newValue) {
        setState(() {
          _selectedPeriod = newValue!;
        });
      },
      items: <String>['1week', '1month', '1year', 'all']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget _buildGenderPlayCountSection() {
    return Card(
      color: Colors.grey[850],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Gender', style: TextStyle(color: Colors.white)),
              ],
            ),
            const SizedBox(height: 32),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 0,
                  centerSpaceRadius: 70,
                  startDegreeOffset: -90,
                  sections: [
                    PieChartSectionData(
                      color: Colors.greenAccent,
                      value: 65,
                      title: '65%',
                      radius: 60,
                      titleStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      color: Colors.pinkAccent,
                      value: 33,
                      title: '33%',
                      radius: 60,
                      titleStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      color: Colors.yellowAccent,
                      value: 2,
                      title: '2%',
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
            _buildLegend('Male', Colors.greenAccent),
            const SizedBox(height: 8),
            _buildLegend('Female', Colors.pinkAccent),
            const SizedBox(height: 8),
            _buildLegend('Unknown', Colors.yellowAccent),
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

  Widget _buildGenerationSection() {
    return Card(
      color: Colors.grey[850],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Generation', style: TextStyle(color: Colors.white)),
              ],
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                const Expanded(
                  flex: 2,
                  child: Text('Age', style: TextStyle(color: Colors.white)),
                ),
                Expanded(
                  flex: 7,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [],
                    ),
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: Text('%',
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.right),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildGenerationBar('Under 20', 23, Colors.yellow),
            _buildGenerationBar('21-30', 54, Colors.pink),
            _buildGenerationBar('31-40', 21, Colors.green),
            _buildGenerationBar('41-50', 1, Colors.orange),
            _buildGenerationBar('Above 51', 1, Colors.purple),
          ],
        ),
      ),
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

  Widget _buildTrendingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Trending', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) {
            return _buildTrendingItem(index);
          },
        ),
      ],
    );
  }

  Widget _buildTrendingItem(int index) {
    final rank = index + 1;
    final isUp = index % 2 == 0;
    final changeIcon = isUp ? Icons.arrow_upward : Icons.arrow_downward;
    final changeColor = isUp ? Colors.green : Colors.red;

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
          Icon(changeIcon, color: changeColor),
          const SizedBox(width: 10),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://ogre.natalie.mu/media/news/music/2024/0913/Thefin_jkt2014.jpg?imwidth=750&imdensity=1'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Song name $rank',
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
                'Total: ${1000000 - index * 100000}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                'Week: ${100000 - index * 10000}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ],
      ),
    );
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
      leading: CircleAvatar(
        child: imageUrl != null
            ? Image.network(imageUrl!)
            : const Icon(Icons.person),
      ),
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
              Text('新規アーティストを追加'),
            ],
          ),
        ),
      ),
    );
  }
}
