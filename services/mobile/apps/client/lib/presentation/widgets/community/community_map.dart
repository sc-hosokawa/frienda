import 'dart:math';
import 'package:flutter/material.dart';
import 'package:client/data/model/community/member.dart';
import 'package:client/presentation/providers/user_provider.dart';
import 'community_graph_painter.dart';

class CommunityMap extends StatefulWidget {
  final List<CommunityMember> members;
  final UserData? currentUser;

  const CommunityMap({
    super.key,
    required this.members,
    required this.currentUser,
  });

  @override
  State<CommunityMap> createState() => _CommunityMapState();
}

class _CommunityMapState extends State<CommunityMap> {
  final Map<String, bool> _filters = {
    'musician': true,
    'curator': true,
    'creator': true,
    'supporter': true,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          // グラフ表示エリア
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                final height = constraints.maxHeight;
                final radius = min(width, height) * 0.3;

                return SizedBox(
                  width: width,
                  height: height,
                  child: CustomPaint(
                    painter: CommunityGraphPainter(
                      members: widget.members
                          .where((m) =>
                              _filters[m.category?.toLowerCase() ?? ''] ?? true)
                          .toList(),
                      currentUser: widget.currentUser,
                      width: width,
                      height: height,
                      radius: radius,
                    ),
                  ),
                );
              },
            ),
          ),
          // フィルター部分（下部に移動）
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Filter',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  // フィルターを並びに
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: _buildFilterItems(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildFilterItems() {
    final filterItems = [
      (
        'musician',
        'Musician',
        const Color(0xFFFF7178),
        const Color(0xFF562C2E)
      ),
      ('curator', 'Curator', const Color(0xFFFF692D), const Color(0xFF6E321A)),
      ('creator', 'Creator', const Color(0xFFE1F000), const Color(0xFF4D520A)),
      (
        'supporter',
        'Supporter',
        const Color(0xFFE4DBC0),
        const Color(0xFF4E4C43)
      ),
    ];

    return filterItems.map((item) {
      return SizedBox(
        width: 85,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: item.$4,
                  border: Border.all(color: item.$3, width: 2),
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  item.$2,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Checkbox(
                value: _filters[item.$1] ?? true,
                onChanged: (value) {
                  setState(() {
                    _filters[item.$1] = value ?? true;
                  });
                },
                fillColor: MaterialStateProperty.resolveWith(
                  (states) => states.contains(MaterialState.selected)
                      ? item.$3
                      : Colors.transparent,
                ),
                checkColor: Colors.black,
                side: BorderSide(color: item.$3),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }
}
