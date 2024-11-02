import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:client/presentation/providers/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewArtists extends ConsumerStatefulWidget {
  const NewArtists({super.key});

  @override
  ConsumerState<NewArtists> createState() => _NewArtistsState();
}

class _NewArtistsState extends ConsumerState<NewArtists> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';
  final Set<String> _selectedArtistIds = {};

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

  static const String requestAccessMutation = r'''
    mutation RequestAccess($userId: String!, $artistIds: [String!]!) {
      requestToAccessArtist(input: {
        userId: $userId,
        artistIds: $artistIds
      }) {
        createdMappings {
          mappingId
          id
          artistId
          name
          imageUrl
          fsp
          status
          isAdmin
        }
      }
    }
  ''';

  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(userProvider);

    if (userData == null) {
      return const Center(child: Text('ユーザー情報が取得できません'));
    }

    return Query(
      options: QueryOptions(
        document: gql(searchArtistsQuery),
        variables: {'name': _searchText},
      ),
      builder: (QueryResult result,
          {VoidCallback? refetch, FetchMore? fetchMore}) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('アーティストを探す'),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            centerTitle: true,
            titleTextStyle: Theme.of(context).textTheme.titleMedium,
          ),
          body: Column(
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
                            _selectedArtistIds.clear();
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
          ),
          floatingActionButton: _selectedArtistIds.isNotEmpty
              ? Mutation(
                  options: MutationOptions(
                    document: gql(requestAccessMutation),
                    onCompleted: (dynamic resultData) {
                      if (resultData != null &&
                          resultData['requestToAccessArtist'] != null) {
                        // 新しく作成されたマッピング情報を取得
                        final createdMappings =
                            (resultData['requestToAccessArtist']
                                    ['createdMappings'] as List)
                                .map((mapping) => ArtistByUser.fromJson(
                                    mapping as Map<String, dynamic>))
                                .toList();

                        // 現在のユーザー情報を取得
                        final currentUser = ref.read(userProvider);
                        if (currentUser != null) {
                          // 新しいアーティストリストを作成（既存 + 新規）
                          final updatedArtists = [
                            ...currentUser.belongsToArtists,
                            ...createdMappings,
                          ];

                          // ユーザー情報を更新
                          ref.read(userProvider.notifier).updateUser(
                                currentUser.copyWith(
                                  belongsToArtists: updatedArtists,
                                ),
                              );
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('アクセスリクエストを送信しました'),
                          ),
                        );
                        setState(() {
                          _selectedArtistIds.clear();
                        });
                      }
                    },
                    onError: (error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'エラーが発生しました: ${error?.graphqlErrors.first.message}'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    },
                  ),
                  builder: (RunMutation runMutation, QueryResult? result) {
                    return FloatingActionButton.extended(
                      onPressed: () {
                        runMutation({
                          'userId': userData.id,
                          'artistIds': List<String>.from(_selectedArtistIds),
                        });
                      },
                      label: const Text('リクエスト'),
                      icon: const Icon(Icons.send),
                    );
                  },
                )
              : null,
        );
      },
    );
  }

  Widget _buildSearchResults(QueryResult result) {
    if (result.data == null ||
        result.data!['getArtistsByName'] == null ||
        result.data!['getArtistsByName']['artistList'] == null ||
        (result.data!['getArtistsByName']['artistList'] as List).isEmpty) {
      return const Center(child: Text('検索結果がありません'));
    }

    final artists = (result.data!['getArtistsByName']['artistList'] as List)
        .map((artist) => ArtistByUser.fromJson(artist as Map<String, dynamic>))
        .toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '選択中: ${_selectedArtistIds.length}件',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: artists.length,
            itemBuilder: (context, index) {
              final artist = artists[index];
              return CheckboxListTile(
                title: Text(artist.name),
                value: _selectedArtistIds.contains(artist.artistId),
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      _selectedArtistIds.add(artist.artistId);
                    } else {
                      _selectedArtistIds.remove(artist.artistId);
                    }
                  });
                },
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
