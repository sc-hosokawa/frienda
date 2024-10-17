import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String _selectedArtist = 'Artist 1';

  static const _gridColor = Color(0xffe7e8ec);
  static const _borderColor = Color(0xff37434d);
  static const _textColor = Color(0xff67727d);

  LineChartData _createChartData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: 1,
        getDrawingHorizontalLine: (_) => FlLine(
          color: _gridColor,
          strokeWidth: 1,
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
        bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
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
          ),
          const SizedBox(height: 20),
          AspectRatio(
            aspectRatio: 1,
            child: LineChart(_createChartData()),
          ),
        ],
      ),
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
