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

class User {
  final String userId;
  final String email;
  final String username;
  final String fullName;
  final String? role;

  User({
    required this.userId,
    required this.email,
    required this.username,
    required this.fullName,
    this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      email: json['email'],
      username: json['username'],
      fullName: json['fullName'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'username': username,
      'fullName': fullName,
      if (role != null) 'role': role,
    };
  }
}
class LoginResponse {
  final int statusCode;
  final String message;
  final String accessToken;
  final String refreshToken;
  final User user;

  LoginResponse({
    required this.statusCode,
    required this.message,
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      accessToken: json['accessToken'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
      user: User.fromJson(json['user'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'message': message,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'user': user.toJson(),
    };
  }
}
// Register Request Model
class RegisterRequest {
  final String username;
  final String email;
  final String password;
  final String fullName;
  final String phoneNumber;

  RegisterRequest({
    required this.username,
    required this.email,
    required this.password,
    required this.fullName,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
    };
  }
}

// Register Response Model
class RegisterResponse {
  final String message;
  final String token;
  final String codes;


  RegisterResponse({
    required this.message,
    required this.token,
    required this.codes
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      message: json['message'],
      token: json['token'],
      codes: json['codes']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'token': token,
      'codes': codes,
    };
  }
}