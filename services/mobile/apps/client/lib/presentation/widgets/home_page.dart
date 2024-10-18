import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ferry/ferry.dart';
import 'package:ferry_flutter/ferry_flutter.dart';
import 'package:client/presentation/providers/client_provider.dart';
import 'package:client/presentation/widgets/message/message_list.dart';
import 'package:client/presentation/widgets/message/message_room.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _isLoading = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _isLoading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildActionsSection(),
          _buildMessagesSection(),
          _buildNewsSection(),
          _buildTrendingSection(),
        ],
      ),
    );
  }

  Widget _buildActionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('Actions', style: Theme.of(context).textTheme.titleSmall),
        ),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.only(left: 16, right: index == 4 ? 16 : 0),
                child: SizedBox(
                  width: 240,
                  child: Center(child: Text('Action ${index + 1}')),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMessagesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Messages', style: Theme.of(context).textTheme.titleSmall),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MessageList()),
                  );
                },
                child: Text('View all'),
              ),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                child: Text('U${index + 1}'),
              ),
              title: Text('User ${index + 1}'),
              subtitle: Text('Latest message from User ${index + 1}'),
              trailing: Text('${index + 1}m ago'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MessageRoom()),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildNewsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('News', style: Theme.of(context).textTheme.titleSmall),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5, // 仮のアイテム数
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.only(left: 16, right: index == 4 ? 16 : 0),
                child: SizedBox(
                  width: 300,
                  child: Center(child: Text('News ${index + 1}')),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTrendingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              Text('Trending', style: Theme.of(context).textTheme.titleSmall),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) {
            return _buildTrendingItem(index);
          },
        ),
      ],
    );
  }

  Widget _buildTrendingItem(int index) {
    final rank = index + 1;
    final isUp = index % 2 == 0;
    final changeIcon = isUp ? Icons.arrow_upward : Icons.arrow_downward;
    final changeColor = isUp ? Colors.green : Colors.red;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          SizedBox(
            width: 30,
            child: Text(
              '$rank',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          Icon(changeIcon, color: changeColor),
          const SizedBox(width: 10),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://ogre.natalie.mu/media/news/music/2024/0913/Thefin_jkt2014.jpg?imwidth=750&imdensity=1'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Song name $rank',
                  style: Theme.of(context).textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Total: ${1000000 - index * 100000}',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                'Week: ${100000 - index * 10000}',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
