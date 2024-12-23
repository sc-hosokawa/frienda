import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:client/data/model/community/member.dart';
import 'package:client/domain/entities/user.dart';

class CommunityGraphPainter extends CustomPainter {
  final List<CommunityMember> members;
  final User? currentUser;
  final double width;
  final double height;
  final double radius;
  final Map<String, ui.Image?> _imageCache = {};

  CommunityGraphPainter({
    required this.members,
    required this.currentUser,
    required this.width,
    required this.height,
    required this.radius,
  });

  final Map<String, Color> categoryBorderColors = {
    'musician': const Color(0xFFFF7178),
    'curator': const Color(0xFFFF692D),
    'creator': const Color(0xFFE1F000),
    'supporter': const Color(0xFFE4DBC0),
  };

  final Map<String, Color> categoryBackgroundColors = {
    'musician': const Color(0xFF562C2E),
    'curator': const Color(0xFF6E321A),
    'creator': const Color(0xFF4D520A),
    'supporter': const Color(0xFF4E4C43),
  };

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = width / 2;
    final centerY = height / 2;
    final positions = _calculateNodePositions();

    // 接続線を描画
    _drawConnections(canvas, positions, centerX, centerY);

    // メンバーノードを描画
    _drawNodes(canvas, positions);

    // 中央のユーザーノードを描画
    _drawCenterNode(canvas, centerX, centerY);
  }

  Map<String, Offset> _calculateNodePositions() {
    final positions = <String, Offset>{};
    final centerX = width / 2;
    final centerY = height / 2;
    final spacing = 2 * pi / members.length;

    // 初期位置の計算
    for (var i = 0; i < members.length; i++) {
      final angle = spacing * i;
      final radiusWithVariation = radius + (Random().nextDouble() * 50 - 25);
      positions[members[i].id] = Offset(
        centerX + radiusWithVariation * cos(angle),
        centerY + radiusWithVariation * sin(angle),
      );
    }

    // 位置の最適化
    for (var i = 0; i < 50; i++) {
      _optimizePositions(positions, centerX, centerY);
    }

    return positions;
  }

  void _optimizePositions(
      Map<String, Offset> positions, double centerX, double centerY) {
    const nodeRadius = 35.0;
    const minDistance = nodeRadius * 3;

    positions.forEach((id1, pos1) {
      positions.forEach((id2, pos2) {
        if (id1 != id2) {
          final dx = pos2.dx - pos1.dx;
          final dy = pos2.dy - pos1.dy;
          final distance = sqrt(dx * dx + dy * dy);

          if (distance < minDistance) {
            final angle = atan2(dy, dx);
            final moveDistance = (minDistance - distance) / 2;

            positions[id2] = Offset(
              pos2.dx + cos(angle) * moveDistance,
              pos2.dy + sin(angle) * moveDistance,
            );
            positions[id1] = Offset(
              pos1.dx - cos(angle) * moveDistance,
              pos1.dy - sin(angle) * moveDistance,
            );

            // 中心からの距離制限
            for (var id in [id1, id2]) {
              final pos = positions[id]!;
              final centerDistance = sqrt(
                pow(pos.dx - centerX, 2) + pow(pos.dy - centerY, 2),
              );
              if (centerDistance > radius * 1.5) {
                final centerAngle = atan2(pos.dy - centerY, pos.dx - centerX);
                positions[id] = Offset(
                  centerX + radius * 1.5 * cos(centerAngle),
                  centerY + radius * 1.5 * sin(centerAngle),
                );
              }
            }
          }
        }
      });
    });
  }

  void _drawConnections(Canvas canvas, Map<String, Offset> positions,
      double centerX, double centerY) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    for (var member in members) {
      final position = positions[member.id];
      if (position == null) continue;

      final start = Offset(centerX, centerY);
      final end = position;

      // 制御点の計算
      final midX = (start.dx + end.dx) / 2;
      final midY = (start.dy + end.dy) / 2;
      final offset = 30.0;

      final dx = end.dx - start.dx;
      final dy = end.dy - start.dy;
      final distance = sqrt(dx * dx + dy * dy);

      final controlPoint = Offset(
        midX - (dy * offset) / distance,
        midY + (dx * offset) / distance,
      );

      final path = Path()
        ..moveTo(start.dx, start.dy)
        ..quadraticBezierTo(controlPoint.dx, controlPoint.dy, end.dx, end.dy);

      paint.color =
          (categoryBorderColors[member.category?.toLowerCase()] ?? Colors.grey)
              .withOpacity(0.6);
      paint.strokeWidth = 2;
      paint.style = PaintingStyle.stroke;

      // 点線効果
      final dashPath = Path();
      final dash = PathMetric(path: path);
      var distance = 0.0;
      final length = dash.length;
      const dashWidth = 4.0;
      const dashSpace = 4.0;

      while (distance < length) {
        final start = distance;
        final end = start + dashWidth;
        if (end <= length) {
          dashPath.addPath(
            path.extractPath(start, end),
            Offset.zero,
          );
        }
        distance = end + dashSpace;
      }

      canvas.drawPath(dashPath, paint);
    }
  }

  void _drawNodes(Canvas canvas, Map<String, Offset> positions) {
    for (var member in members) {
      final position = positions[member.id];
      if (position == null) continue;

      final category = member.category?.toLowerCase() ?? 'supporter';

      // 背景円を描画
      final bgPaint = Paint()
        ..style = PaintingStyle.fill
        ..color = categoryBackgroundColors[category] ?? Colors.grey;

      final borderPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = categoryBorderColors[category] ?? Colors.grey;

      canvas.drawCircle(position, 38, bgPaint);
      canvas.drawCircle(position, 38, borderPaint);

      // プロフィール画像を描画
      if (member.imageUrl != null) {
        _drawProfileImage(canvas, position, member.imageUrl!, 32);
      }

      // 名前を描画
      _drawText(canvas, member.name ?? '', position + const Offset(0, 50));
    }
  }

  void _drawCenterNode(Canvas canvas, double centerX, double centerY) {
    final center = Offset(centerX, centerY);
    final category = currentUser?.role?.toLowerCase() ?? 'supporter';

    final bgPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = categoryBackgroundColors[category] ?? Colors.grey;

    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = categoryBorderColors[category] ?? Colors.grey;

    canvas.drawCircle(center, 43, bgPaint);
    canvas.drawCircle(center, 43, borderPaint);

    _drawProfileImage(
      canvas,
      center,
      currentUser?.imageUrl ?? 'assets/logo_visualonly.jpg',
      37,
    );

    _drawText(canvas, 'You', center + const Offset(0, 60));
  }

  void _drawProfileImage(
      Canvas canvas, Offset center, String imageUrl, double radius) {
    final image = _imageCache[imageUrl];
    if (image == null) return;

    final rect = Rect.fromCircle(center: center, radius: radius);
    final clipPath = Path()..addOval(rect);

    canvas.save();
    canvas.clipPath(clipPath);
    canvas.drawImageRect(
      image,
      Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
      rect,
      Paint(),
    );
    canvas.restore();
  }

  void _drawText(Canvas canvas, String text, Offset position) {
    final textSpan = TextSpan(
      text: text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14,
      ),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      position.translate(-textPainter.width / 2, -textPainter.height / 2),
    );
  }

  @override
  bool shouldRepaint(CommunityGraphPainter oldDelegate) => true;
}
