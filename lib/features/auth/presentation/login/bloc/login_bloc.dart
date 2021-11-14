import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:refocus_app/features/auth/presentation/models/models.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(_LoginStateCurrent()) {
    on<LoginEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
