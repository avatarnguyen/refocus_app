import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// ignore_for_file: prefer_asserts_with_message
//ignore_for_file: unnecessary_null_comparison
T useBloc<T extends Bloc<dynamic, dynamic>>(
  T Function() blocFactory, [
  List<Object> keys = const <Object>[],
]) {
  return use(_BlocHook(
    blocFactory,
    keys: keys,
  ));
}

class _BlocHook<T extends Bloc<dynamic, dynamic>> extends Hook<T> {
  const _BlocHook(
    this.blocFactory, {
    List<Object> keys = const <Object>[],
  })  : assert(blocFactory != null),
        assert(keys != null),
        super(keys: keys);

  final T Function() blocFactory;

  @override
  _BlocHookState<T> createState() => _BlocHookState<T>();
}

class _BlocHookState<T extends Bloc<dynamic, dynamic>> extends HookState<T, _BlocHook<T>> {
  late T bloc;

  @override
  void initHook() {
    super.initHook();
    bloc = hook.blocFactory();
  }

  @override
  T build(BuildContext context) {
    return bloc;
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }
}
