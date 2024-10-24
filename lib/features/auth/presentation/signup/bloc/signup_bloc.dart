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
      _SignupUsernameChanged event, Emitter<SignupState> emit) async {
    final _username = Username.dirty(event.username);
    emit(state.copyWith(
      username: _username,
      status: Formz.validate([
        state.password ?? const Password.pure(),
        state.email ?? const Email.pure(),
        _username,
      ]),
    ));
  }

  Future<void> _onSignupEmailChanged(
      _SignupEmailChanged event, Emitter<SignupState> emit) async {
    final _email = Email.dirty(event.email);
    emit(state.copyWith(
      email: _email,
      status: Formz.validate([
        state.password ?? const Password.pure(),
        state.username ?? const Username.pure(),
        _email,
      ]),
    ));
  }

  Future<void> _onSignupPasswordChanged(
      _SignupPasswordChanged event, Emitter<SignupState> emit) async {
    final _password = Password.dirty(event.password);
    emit(state.copyWith(
      password: _password,
      status: Formz.validate([
        state.username ?? const Username.pure(),
        state.email ?? const Email.pure(),
        _password,
      ]),
    ));
  }

  Future<void> _onSubmitted(
      _SignupSubmitted event, Emitter<SignupState> emit) async {
    if (state.status?.isValid == true) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        await _signUp(AuthParams(
          email: state.email?.value,
          username: state.username?.value,
          password: state.password?.value,
        ));
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (e) {
        log.e(e);
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
