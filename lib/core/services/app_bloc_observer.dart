
import 'package:chefaa/core/imports/imports.dart';
class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    debugPrint('🟠 Event: ${bloc.runtimeType} => $event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    debugPrint('🔵 Transition: ${bloc.runtimeType} => $transition');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    debugPrint('🟢 Change: ${bloc.runtimeType} => $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    debugPrint('🔴 Error: ${bloc.runtimeType} => $error');
  }
}
