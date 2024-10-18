import 'package:flutter/material.dart';

Future<void> navigateWithFadeTransition(
  BuildContext context,
  Widget destinationPage, {
  Duration transitionDuration = const Duration(milliseconds: 5),
  Duration delayDuration = const Duration(milliseconds: 5),
}) async {
  if (!context.mounted) return;

  await Future.delayed(delayDuration);

  if (!context.mounted) return;

  final navigator = Navigator.of(context);
  await navigator.push(
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => destinationPage,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      transitionDuration: transitionDuration,
    ),
  );
}
