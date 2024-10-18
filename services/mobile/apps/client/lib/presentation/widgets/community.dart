import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_graph_view/flutter_graph_view.dart';

// グローバル変数として vertex の保存用 Map を追加
Map<String, Vertex> vertexStorage = {};

class Community extends StatefulWidget {
  const Community({super.key});

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  // vertex の保存と読み込みのための関数を追加
  void saveVertex(Vertex v) {
    vertexStorage[v.id as String] = v;
  }

  Map<String, Vertex?> loadVertex() {
    return vertexStorage;
  }

  @override
  Widget build(BuildContext context) {
    var vertexes = <Map>{};
    var r = Random();
    for (var i = 0; i < 10; i++) {
      vertexes.add(
        {
          'id': 'node$i',
          'tag': 'tag${r.nextInt(9)}',
          'tags': [
            'tag${r.nextInt(9)}',
            if (r.nextBool()) 'tag${r.nextInt(4)}',
            if (r.nextBool()) 'tag${r.nextInt(8)}'
          ],
        },
      );
    }
    var edges = <Map>{};

    for (var i = 1; i < 10; i++) {
      edges.add({
        'srcId': 'node0',
        'dstId': 'node$i',
        'edgeName': 'edge${r.nextInt(3)}',
        'ranking': DateTime.now().millisecond,
      });
    }

    var data = {
      'vertexes': vertexes,
      'edges': edges,
    };

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2,
      child: FlutterGraphWidget(
        data: data,
        algorithm: RandomAlgorithm(
          decorators: [
            PersistenceDecorator(
                saveVertex, loadVertex), // PersistenceDecorator を追加
            CoulombDecorator(),
            HookeDecorator(),
            HookeCenterDecorator(),
          ],
        ),
        convertor: MapConvertor(),
        options: Options()
          ..enableHit = false
          ..panelDelay = const Duration(milliseconds: 500)
          ..graphStyle = (GraphStyle()
            ..tagColor = {'tag8': Colors.orangeAccent.shade200}
            ..tagColorByIndex = [
              Colors.red.shade200,
              Colors.orange.shade200,
              Colors.yellow.shade200,
              Colors.green.shade200,
              Colors.blue.shade200,
              Colors.blueAccent.shade200,
              Colors.purple.shade200,
              Colors.pink.shade200,
              Colors.blueGrey.shade200,
              Colors.deepOrange.shade200,
            ])
          ..useLegend = false
          ..edgePanelBuilder = edgePanelBuilder
          ..vertexPanelBuilder = vertexPanelBuilder
          ..edgeShape = EdgeLineShape()
          ..vertexShape = VertexCircleShape(),
      ),
    );
  }

  Widget edgePanelBuilder(Edge edge, Viewfinder viewfinder) {
    var c = viewfinder.localToGlobal(edge.position);

    return Stack(
      children: [
        Positioned(
          left: c.x + 5,
          top: c.y,
          child: SizedBox(
            width: 200,
            child: ColoredBox(
              color: Colors.grey.shade900.withAlpha(200),
              child: ListTile(
                title: Text(
                    '${edge.edgeName} @${edge.ranking}\nDelay controlled by \noptions.panelDelay\ndefault to 300ms'),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget vertexPanelBuilder(hoverVertex, Viewfinder viewfinder) {
    var c = viewfinder.localToGlobal(hoverVertex.cpn!.position);
    return Stack(
      children: [
        Positioned(
          left: c.x + hoverVertex.radius + 5,
          top: c.y - 20,
          child: SizedBox(
            width: 120,
            child: ColoredBox(
              color: Colors.grey.shade900.withAlpha(200),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Id: ${hoverVertex.id}',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Degree: ${hoverVertex.degree}',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Prev: ${hoverVertex.prevVertex?.id}',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Tag: ${hoverVertex.data['tag']}',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
