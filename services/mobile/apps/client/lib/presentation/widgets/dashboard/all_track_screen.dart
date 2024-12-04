import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:client/presentation/providers/user_provider.dart';
import 'package:client/presentation/widgets/dashboard/product_detail_screen.dart';

class AllTracksScreen extends ConsumerWidget {
  final String artistId;
  final String artistName;

  const AllTracksScreen({
    super.key,
    required this.artistId,
    required this.artistName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('$artistName の作品一覧'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'アルバム'),
              Tab(text: 'シングル'),
              Tab(text: 'EP'),
            ],
          ),
        ),
        body: Query(
          options: QueryOptions(
            document: gql('''
              query GetProducts(\$artistId: String!) {
                getProducts(artistId: \$artistId) {
                  album {
                    product {
                      upc
                      title
                      imgUrl
                      type
                    }
                    tracks {
                      isrc
                      title
                    }
                  }
                  single {
                    product {
                      upc
                      title
                      imgUrl
                      type
                    }
                    tracks {
                      isrc
                      title
                    }
                  }
                  ep {
                    product {
                      upc
                      title
                      imgUrl
                      type
                    }
                    tracks {
                      isrc
                      title
                    }
                  }
                }
              }
            '''),
            variables: {
              'artistId': artistId,
            },
          ),
          builder: (result, {refetch, fetchMore}) {
            if (result.hasException) {
              return Center(
                  child: Text('Error: ${result.exception.toString()}'));
            }

            if (result.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            final productsData = result.data?['getProducts'];
            final albums = productsData?['album'] as List<dynamic>? ?? [];
            final singles = productsData?['single'] as List<dynamic>? ?? [];
            final eps = productsData?['ep'] as List<dynamic>? ?? [];

            return TabBarView(
              children: [
                _ProductList(
                  products: albums,
                  artistId: artistId,
                ),
                _ProductList(products: singles, artistId: artistId),
                _ProductList(products: eps, artistId: artistId),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ProductList extends StatelessWidget {
  final List<dynamic> products;
  final String artistId;

  const _ProductList({
    required this.products,
    required this.artistId,
  });

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const Center(
        child: Text('作品がありません'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final productWithTracks = products[index];
        final product = productWithTracks['product'];
        final tracks = productWithTracks['tracks'] as List<dynamic>;

        return _ProductListItem(
          title: product['title'] ?? 'Unknown Title',
          imageUrl: product['imgUrl'],
          tracksCount: tracks.length,
          upc: product['upc'] ?? '',
          tracks: tracks,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailScreen(
                  title: product['title'] ?? 'Unknown Title',
                  upc: product['upc'] ?? '',
                  tracks: tracks,
                  artistId: artistId,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _ProductListItem extends StatelessWidget {
  final String title;
  final String? imageUrl;
  final int tracksCount;
  final String upc;
  final List<dynamic> tracks;
  final VoidCallback onTap;

  const _ProductListItem({
    required this.title,
    this.imageUrl,
    required this.tracksCount,
    required this.upc,
    required this.tracks,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  image: imageUrl != null
                      ? DecorationImage(
                          image: NetworkImage(imageUrl!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: imageUrl == null ? const Icon(Icons.music_note) : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '収録曲数: $tracksCount',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      'UPC: $upc',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
