import 'package:equatable/equatable.dart';

class AuthParams extends Equatable {
  const AuthParams({
    this.id,
    this.username,
    this.email,
    this.password,
    this.confirmationCode,
  });

  final String? id;
  final String? username;
  final String? email;
  final String? password;
  final String? confirmationCode;

  @override
  List<Object?> get props => [id, username, email, password, confirmationCode];
}
