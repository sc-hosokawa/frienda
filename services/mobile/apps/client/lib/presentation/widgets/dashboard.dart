import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:countries_world_map/countries_world_map.dart';
import 'package:countries_world_map/data/maps/world_map.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String _selectedArtist = 'Artist 1';
  String _selectedSong = 'Song 1';
  String _selectedPeriod = '1week';

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
            getTitlesWidget: (value, _) => Text(
              'Day ${value.toInt() + 1}',
              style: const TextStyle(
                color: _textColor,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
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
          const _AddNewArtistButton(),
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
  Widget build(BuildContext context) {
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
            _buildLineChartSection(),
            const SizedBox(height: 20),
            _buildGenderPlayCountSection(),
            const SizedBox(height: 20),
            _buildGenerationSection(),
            const SizedBox(height: 20),
            _buildWorldwidePlayCountSection(),
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
            _selectedArtist,
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
              const VerticalDivider(thickness: 1, width: 1),
              _buildStatItem('Song Played', '98,765', 'Week'),
              const VerticalDivider(thickness: 1, width: 1),
              _buildStatItem('Listeners', '543,210', 'Total'),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('再生数推移', style: Theme.of(context).textTheme.titleMedium),
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
        AspectRatio(
          aspectRatio: 1.5,
          child: LineChart(_createChartData()),
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
      color: Colors.grey[850], // 真っ黒から濃いグレーに変更
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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

  Widget _buildWorldwidePlayCountSection() {
    final Map<String, int> playCountData = {
      'US': 1000000,
      'GB': 500000,
      'JP': 750000,
      'DE': 300000,
      'FR': 250000,
    };

    return Card(
      color: Colors.grey[850],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            AspectRatio(
              aspectRatio: 16 / 9,
              child: SimpleMap(
                instructions: SMapWorld.instructions,
                defaultColor: Colors.grey,
                colors: SMapWorldColors(
                  uS: Colors.green,
                  cN: Colors.green,
                  rU: Colors.green,
                ).toMap(),
                callback: (id, name, tapdetails) {
                  // タップされた国の処理をここに追加
                  print('Tapped on country: $name');
                },
              ),
            ),
            const SizedBox(height: 16),
            _buildLegendWorldMap(),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendWorldMap() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildLegendItem('> 750K', Colors.red),
          const SizedBox(width: 8),
          _buildLegendItem('500K-750K', Colors.orange),
          const SizedBox(width: 8),
          _buildLegendItem('250K-500K', Colors.yellow),
          const SizedBox(width: 8),
          _buildLegendItem('< 250K', Colors.green),
          const SizedBox(width: 8),
          _buildLegendItem('No data', Colors.grey),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          color: color,
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }
}

class _ArtistList extends StatelessWidget {
  final Function(String) onSelectArtist;

  const _ArtistList({super.key, required this.onSelectArtist});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Center(
            child: Text('選択可能なアーティスト', style: TextStyle(fontSize: 16)),
          ),
        ),
        for (final artist in ['Artist 1', 'Artist 2', 'Artist 3', 'Artist 4'])
          _ArtistListTile(
            artist: artist,
            onTap: () => onSelectArtist(artist),
          ),
      ],
    );
  }
}

class _ArtistListTile extends StatelessWidget {
  final String artist;
  final VoidCallback onTap;

  const _ArtistListTile({super.key, required this.artist, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        child: Icon(Icons.person),
      ),
      title: Text(artist),
      onTap: onTap,
    );
  }
}

class _AddNewArtistButton extends StatelessWidget {
  const _AddNewArtistButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          // TODO: 新規アーティスト追加の処理を実装
          Navigator.pop(context);
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
