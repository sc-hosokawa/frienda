import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_graph_view/flutter_graph_view.dart';
import 'package:client/presentation/widgets/community/details.dart';

Map<String, Vertex> vertexStorage = {};

class Community extends StatefulWidget {
  const Community({super.key});

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  String _selectedView = 'Map View';

  void saveVertex(Vertex v) {
    vertexStorage[v.id as String] = v;
  }

  Map<String, Vertex?> loadVertex() {
    return vertexStorage;
  }

  // 円形レイアウトの初期位置を計算する関数
  Map<String, Offset> calculateInitialPositions(
      double radius, bool isHalfCircle) {
    Map<String, Offset> positions = {};
    int nodeCount = 9; // node1からnode9まで

    // 中心のnode0の位置
    positions['node0'] = const Offset(0, 0);

    // 周りのノードの位置を計算
    for (int i = 1; i <= nodeCount; i++) {
      // 角度の計算（半円の場合は180度、円の場合は360度で分割）
      double angle = (isHalfCircle ? pi : 2 * pi) * (i - 1) / nodeCount;
      if (isHalfCircle) {
        // 半円の場合は角度を調整（0°から180°の範囲にする）
        angle = pi - angle;
      }

      // 極座標から直交座標に変換
      double x = radius * cos(angle);
      double y = radius * sin(angle);

      positions['node$i'] = Offset(x, y);
    }

    return positions;
  }

  @override
  Widget build(BuildContext context) {
    // 初期位置を計算（radius は適宜調整）
    final initialPositions = calculateInitialPositions(
        200, false); // false for full circle, true for half circle

    var vertexes = <Map>{};
    var r = Random();

    // node0（中心ノード）の追加
    vertexes.add({
      'id': 'node0',
      'tag': 'tag${r.nextInt(9)}',
      'tags': [
        'tag${r.nextInt(9)}',
        if (r.nextBool()) 'tag${r.nextInt(4)}',
        if (r.nextBool()) 'tag${r.nextInt(8)}'
      ],
      'position': initialPositions['node0'], // 初期位置を設定
    });

    // 周りのノードの追加
    for (var i = 1; i < 10; i++) {
      vertexes.add({
        'id': 'node$i',
        'tag': 'tag${r.nextInt(9)}',
        'tags': [
          'tag${r.nextInt(9)}',
          if (r.nextBool()) 'tag${r.nextInt(4)}',
          if (r.nextBool()) 'tag${r.nextInt(8)}'
        ],
        'position': initialPositions['node$i'], // 初期位置を設定
      });
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

    return Column(
      children: [
        // ドロップダウンメニュー
        DropdownButton<String>(
          value: _selectedView,
          items: ['Map View', 'List View']
              .map((String value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  ))
              .toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                _selectedView = newValue;
              });
            }
          },
        ),
        // グラフ表示
        Expanded(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: _selectedView == 'Map View'
                ? FlutterGraphWidget(
                    data: data,
                    algorithm: RandomAlgorithm(
                      decorators: [
                        PersistenceDecorator(saveVertex, loadVertex),
                        CoulombDecorator(k: 1000), // 反発力を調整
                        HookeDecorator(length: 1000, k: 0.01), // バネの強さを調整
                        HookeCenterDecorator(
                            length: 1000, k: 0.01), // 中心への引力を調整
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
                  )
                : _buildListView(vertexes.toList()),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: _buildTags(),
        ),
      ],
    );
  }

  Widget _buildTags() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildTagItem('Musician', Colors.blue),
          const SizedBox(width: 8),
          _buildTagItem('Curator', Colors.green),
          const SizedBox(width: 8),
          _buildTagItem('Creator', Colors.orange),
          const SizedBox(width: 8),
          _buildTagItem('Supporter', Colors.purple),
        ],
      ),
    );
  }

  Widget _buildTagItem(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 12),
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

  Widget _buildListView(List<Map<dynamic, dynamic>> vertexes) {
    // node0 を除外し、他のノードをリストに表示
    var targetNodes =
        vertexes.where((vertex) => vertex['id'] != 'node0').toList();

    return ListView.builder(
      itemCount: targetNodes.length,
      itemBuilder: (context, index) {
        var node = targetNodes[index];
        return ListTile(
          leading: CircleAvatar(
            // プロフィール画像がない場合はプレースホルダーを表示
            backgroundImage: AssetImage('assets/logo_visualonly.jpg'),
            // 実際のプロフィール画像がある場合は以下のようにします
            // backgroundImage: NetworkImage(node['profileImageUrl']),
          ),
          title: Text(node['id']), // ノードの名前（例：node1）
          subtitle: Text('Type: ${node['tag']}'), // ノードの種類
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NodeDetailPage(node: node),
            ),
          ),
          // 必要に応じて他の属性を表示
        );
      },
    );
  }
}
