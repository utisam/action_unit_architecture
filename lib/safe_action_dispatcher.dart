import 'package:flutter/widgets.dart';

class SafeActionDispatcher extends ActionDispatcher {
  final void Function(
      BuildContext? context, Object error, StackTrace stackTrace) onError;

  SafeActionDispatcher({required this.onError});

  @override
  void invokeAction(covariant Action<Intent> action, covariant Intent intent,
      [BuildContext? context]) {
    final BuildContext? target = context ?? primaryFocus?.context;
    try {
      final result = super.invokeAction(action, intent, target);
      if (result is Future) {
        result.catchError((error, stackTrace) {
          onError(target, error, stackTrace);
        });
      }
    } catch (error, stackTrace) {
      onError(target, error, stackTrace);
    }
  }

  @override
  (bool, Object?) invokeActionIfEnabled(
      covariant Action<Intent> action, covariant Intent intent,
      [BuildContext? context]) {
    final BuildContext? target = context ?? primaryFocus?.context;
    try {
      final (enabled, result) =
          super.invokeActionIfEnabled(action, intent, target);

      if (result is Future) {
        result.catchError((error, stackTrace) {
          onError(target, error, stackTrace);
        });
      }
      return (enabled, result);
    } catch (error, stackTrace) {
      onError(target, error, stackTrace);
      return (true, null);
    }
  }
}
