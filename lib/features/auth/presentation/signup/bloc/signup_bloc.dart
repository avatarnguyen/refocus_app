import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:refocus_app/core/util/helpers/logging.dart';
import 'package:refocus_app/features/auth/domain/usecases/auth_params.dart';
import 'package:refocus_app/features/auth/domain/usecases/confirmation.dart';
import 'package:refocus_app/features/auth/domain/usecases/signup.dart';
import 'package:refocus_app/features/auth/presentation/models/models.dart';

part 'signup_event.dart';
part 'signup_state.dart';
part 'signup_bloc.freezed.dart';

@injectable
class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc({required SignUp signUp, required Confirmation confirmation})
      : _signUp = signUp,
        _confirmation = confirmation,
        super(const _SignupStateCurrent()) {
    on<_SignupUsernameChanged>(_onSignupUsernameChanged);
    on<_SignupEmailChanged>(_onSignupEmailChanged);
    on<_SignupPasswordChanged>(_onSignupPasswordChanged);
    on<_SignupSubmitted>(_onSubmitted);
  }

  final SignUp _signUp;
  final Confirmation _confirmation;
  final log = logger(SignupBloc);

  Future<void> _onSignupUsernameChanged(
      _SignupUsernameChanged event, Emitter<SignupState> emit) async {}
  Future<void> _onSignupEmailChanged(
      _SignupEmailChanged event, Emitter<SignupState> emit) async {}
  Future<void> _onSignupPasswordChanged(
      _SignupPasswordChanged event, Emitter<SignupState> emit) async {}
  Future<void> _onSubmitted(
      _SignupSubmitted event, Emitter<SignupState> emit) async {
    // await _confirmation(const AuthParams(
    //   username: 'avatar',
    //   confirmationCode: '778608',
    // ));
    // await _signUp(AuthParams(
    //   email: ''
    // ));
  }
}

  // Future<void> _onSignUpEvent(
  //     _AuthSignUpEvent event, Emitter<AuthState> emit) async {
  //   final _user = await _signUp(
  //     AuthParams(
  //       username: event.username,
  //       email: event.email,
  //       password: event.password,
  //     ),
  //   );
  //   _user.fold(
  //     (failure) {
  //       if (failure is AuthFailure) {
  //         emit(const AuthState.unauthenticated());
  //       } else {
  //         emit(const AuthState.unknown());
  //       }
  //     },
  //     (entry) => emit(AuthState.authenticated(entry)),
  //   );
  // }
