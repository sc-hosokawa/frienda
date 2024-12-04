import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/presentation/widgets/more.dart';
import 'package:client/presentation/providers/user_provider.dart';
import 'package:client/presentation/providers/fsp_balance_provider.dart';
import 'package:intl/intl.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String title;
  final String defaultProfileImagePath;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.defaultProfileImagePath,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(userProvider);
    final balanceState = ref.watch(balanceStreamProvider);
    final profileImage = userData?.imageUrl;

    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(title),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Row(
            children: [
              balanceState.when(
                data: (balance) => Text(
                  '${NumberFormat('#,###').format(balance.fspBalance)} fsp',
                  style: TextStyle(fontSize: 16),
                ),
                loading: () => const SizedBox.shrink(),
                error: (err, stack) => const SizedBox.shrink(),
              ),
              SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => More()),
                  );
                },
                child: CircleAvatar(
                  radius: 16,
                  backgroundImage: profileImage != null
                      ? NetworkImage(profileImage) as ImageProvider
                      : AssetImage(defaultProfileImagePath),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
