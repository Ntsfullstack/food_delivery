// Login Request Model
class LoginRequest {
  final String email;
  final String password;

  LoginRequest({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}

// User Model
class User {
  final String userID;
  final String email;
  final String username;
  final String fullName;

  User({
    required this.userID,
    required this.email,
    required this.username,
    required this.fullName,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userID: json['UserID'],
      email: json['Email'],
      username: json['Username'],
      fullName: json['FullName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'UserID': userID,
      'Email': email,
      'Username': username,
      'FullName': fullName,
    };
  }
}

// Login Response Model
class LoginResponse {
  final String message;
  final String accessToken;
  final String refreshToken;
  final User user;

  LoginResponse({
    required this.message,
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'],
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'user': user.toJson(),
    };
  }
}
