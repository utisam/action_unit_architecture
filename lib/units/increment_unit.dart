import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IncrementIntent extends Intent {
  const IncrementIntent();
}

class _IncrementAction extends Action<IncrementIntent> {
  final StateController<int> notifier;

  _IncrementAction(this.notifier);

  @override
  void invoke(Intent intent) {
    notifier.state++;
    throw Exception('Example Exception');
  }
}

class IncrementUnit {
  final countProvider = StateProvider.autoDispose((ref) => 0);
  get actionsProvider => Provider.autoDispose<Map<Type, Action>>((ref) {
        final countNotifier = ref.watch(countProvider.notifier);
        return {
          IncrementIntent: _IncrementAction(countNotifier),
        };
      });
}

class IncrementFAB extends StatelessWidget {
  const IncrementFAB({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: Actions.handler(context, const IncrementIntent()),
      tooltip: 'Increment',
      child: const Icon(Icons.add),
    );
  }
}
