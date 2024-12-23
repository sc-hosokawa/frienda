import 'dart:math';
import 'package:flutter/material.dart';
import 'package:client/data/model/community/member.dart';
import 'package:client/domain/entities/user.dart';
import 'community_graph_painter.dart';

class CommunityMap extends StatefulWidget {
  final List<CommunityMember> members;
  final User? currentUser;

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
      child: Row(
        children: [
          // フィルターサイドバー
          Container(
            width: 120,
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
                ..._buildFilterItems(),
              ],
            ),
          ),
          // グラフ表示エリア
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                final height = max(600.0, width * 0.75);
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
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
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
            Expanded(
              child: Text(
                item.$2,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
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
      );
    }).toList();
  }
}
