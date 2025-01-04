import 'package:flutter/material.dart';
import 'package:client/presentation/widgets/dashboard/new_artists.dart';

class ArtistSelectionBottomSheet extends StatelessWidget {
  final Function(String) onSelectArtist;

  const ArtistSelectionBottomSheet({super.key, required this.onSelectArtist});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Column(
        children: [
          Expanded(
            child: _ArtistList(onSelectArtist: onSelectArtist),
          ),
          const _AddNewArtistButton(),
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
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade600), // ボーダーの色と太さを設定
        ),
      ),
      child: ListTile(
        title: Text(artist),
        onTap: onTap,
      ),
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
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const NewArtists(),
            ),
          );
        },
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add),
              SizedBox(width: 4),
              Text('アーティストデータの閲覧権限を申請する'),
            ],
          ),
        ),
      ),
    );
  }
}
