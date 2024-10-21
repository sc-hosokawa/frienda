import 'package:flutter/material.dart';

class NewArtists extends StatefulWidget {
  const NewArtists({super.key});

  @override
  State<NewArtists> createState() => _NewArtistsState();
}

class _NewArtistsState extends State<NewArtists> {
  final List<String> _artists = [
    'アーティスト1',
    'アーティスト2',
    'アーティスト3',
    'アーティスト4',
    'アーティスト5',
    'アーティスト6',
    'アーティスト7',
    'アーティスト8',
    'アーティスト9',
    'アーティスト10',
    'アーティスト11',
    'アーティスト12',
  ];
  final Set<String> _selectedArtists = {};

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 選択されたアーティストを表示するエリア
        Container(
          padding: const EdgeInsets.all(8.0),
          height: 60,
          color: Colors.grey[800],
          child: _selectedArtists.isEmpty
              ? const Center(
                  child: Text(
                    'アーティストが選択されていません',
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              : ListView(
                  scrollDirection: Axis.horizontal,
                  children: _selectedArtists
                      .map((artist) => Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Chip(
                              label: Text(artist),
                              onDeleted: () {
                                setState(() {
                                  _selectedArtists.remove(artist);
                                });
                              },
                            ),
                          ))
                      .toList(),
                ),
        ),
        const Divider(height: 1, thickness: 1),
        Expanded(
          child: ListView.builder(
            itemCount: _artists.length,
            itemBuilder: (context, index) {
              final artist = _artists[index];
              return CheckboxListTile(
                title: Text(artist),
                value: _selectedArtists.contains(artist),
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      _selectedArtists.add(artist);
                    } else {
                      _selectedArtists.remove(artist);
                    }
                  });
                },
              );
            },
          ),
        ),
        ElevatedButton(
          onPressed: _selectedArtists.isNotEmpty
              ? () {
                  print('選択されたアーティスト: $_selectedArtists');
                  // 選択されたアーティストのリストを前の画面に渡して閉じる
                  Navigator.of(context)
                      .pop(List<String>.from(_selectedArtists));
                }
              : null,
          child: const Text('送信'),
        ),
      ],
    );
  }
}
