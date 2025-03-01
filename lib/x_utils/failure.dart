abstract class Failure {
  String? code;
}

abstract class BottomPlacedException extends Failure {}

class UnImplementedFailure extends BottomPlacedException {
  @override
  final code = "An Error occured !";
}

class NetworkException extends BottomPlacedException {
  @override
  final code = "Netwrok connection error !";
}

abstract class AuthException extends Failure {}

abstract class PasswordException extends AuthException {}

abstract class EmailException extends AuthException {}

class WeakPasswordException extends PasswordException {
  @override
  final code = "password should be at least 6 characters.";
}

class WrongPasswordException extends PasswordException {
  @override
  final code = "Your password is wrong.";
}

class InvalidEmailException extends EmailException {
  @override
  final code = "Your email is invalid.";
}

class NotFoundEmailException extends EmailException {
  @override
  final code = "User with this email doesn't exist.";
}

class EmailInUseException extends EmailException {
  @override
  final code = "Email is already in use ";
}

class NoUserSignedInException extends AuthException {
  @override
  final code = "No user signed in";
}

class NoException extends Failure {}
