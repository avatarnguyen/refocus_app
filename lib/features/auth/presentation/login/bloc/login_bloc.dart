import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:refocus_app/features/auth/domain/usecases/login.dart';
import 'package:refocus_app/features/auth/presentation/models/models.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Login _login;

  // ignore: sort_constructors_first
  LoginBloc({required Login login})
      : _login = login,
        super(const _LoginStateCurrent()) {
    on<LoginEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

    // username: 'avatar',
    // password: '123456abc',
    // _user.fold(
    //   (failure) {
    //     if (failure is AuthFailure) {
    //       emit(const AuthState.unauthenticated());
    //     } else {
    //       emit(const AuthState.unknown());
    //     }
    //   },
    //   (entry) => emit(AuthState.authenticated(entry)),
    // );