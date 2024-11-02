import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class NewArtists extends StatefulWidget {
  const NewArtists({super.key});

  @override
  State<NewArtists> createState() => _NewArtistsState();
}

class _NewArtistsState extends State<NewArtists> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';
  List<ArtistData> _artists = [];

  static const String searchArtistsQuery = r'''
    query SearchArtists($name: String!) {
      getArtistsByName(name: $name) {
        artistList {
          id
          artistId
          name
          imageUrl
          fsp
        }
      }
    }
  ''';

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        document: gql(searchArtistsQuery),
        variables: {'name': _searchText},
      ),
      builder: (QueryResult result,
          {VoidCallback? refetch, FetchMore? fetchMore}) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: 'アーティスト名を入力',
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      final searchText = _searchController.text.trim();
                      if (searchText.isNotEmpty) {
                        setState(() {
                          _searchText = searchText;
                        });
                        refetch?.call();
                      }
                    },
                    child: const Text('検索'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: _searchText.isEmpty
                  ? const Center(child: Text('アーティスト名を入力して検索してください'))
                  : result.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : result.hasException
                          ? Center(
                              child: Text('エラーが発生しました: ${result.exception}'))
                          : _buildSearchResults(result),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSearchResults(QueryResult result) {
    if (result.data == null ||
        result.data!['getArtistsByName'] == null ||
        result.data!['getArtistsByName']['artistList'] == null) {
      return const Center(child: Text('検索結果がありません'));
    }

    final artists = (result.data!['getArtistsByName']['artistList'] as List)
        .map((artist) => ArtistData.fromJson(artist as Map<String, dynamic>))
        .toList();

    return ListView.builder(
      itemCount: artists.length,
      itemBuilder: (context, index) {
        final artist = artists[index];
        return ListTile(
          title: Text(artist.name),
          subtitle: Text('FSP: ${artist.fsp}'),
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

class ArtistData {
  final String id;
  final String artistId;
  final String name;
  final String? imageUrl;
  final int fsp;

  ArtistData({
    required this.id,
    required this.artistId,
    required this.name,
    this.imageUrl,
    required this.fsp,
  });

  factory ArtistData.fromJson(Map<String, dynamic> json) {
    return ArtistData(
      id: json['id'],
      artistId: json['artistId'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      fsp: json['fsp'],
    );
  }
}
