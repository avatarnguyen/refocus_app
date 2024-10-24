import 'package:equatable/equatable.dart';

class AuthCredential extends Equatable {
  const AuthCredential({
    this.username,
    this.email,
    this.password,
  });

  final String? username;
  final String? email;
  final String? password;

  @override
  List<Object?> get props => [username, email, password];
}
