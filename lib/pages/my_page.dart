import 'package:action_unit_architecture/pages/my_view_model.dart';
import 'package:action_unit_architecture/units/increment_unit.dart';
import 'package:action_unit_architecture/safe_action_dispatcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:developer' as developer;

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) => Actions(
        dispatcher: SafeActionDispatcher(onError: onError),
        actions: ref.watch(myActionsProvider),
        child: child!,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Example App'),
        ),
        body: const _MyPageBody(),
        floatingActionButton: const IncrementFAB(),
      ),
    );
  }

  void onError(BuildContext? context, Object error, StackTrace stackTrace) {
    developer.log(
      "Error from action",
      error: error,
      stackTrace: stackTrace,
    );
    if (context != null && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.toString()),
      ));
    }
  }
}

class _MyPageBody extends ConsumerWidget {
  const _MyPageBody();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final count = ref.watch(myCountProvider);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'You have pushed the button this many times:',
          ),
          Text(
            '$count',
            style: theme.textTheme.headlineMedium,
          ),
        ],
      ),
    );
  }
}
