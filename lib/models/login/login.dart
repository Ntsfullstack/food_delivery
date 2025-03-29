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

class RegisterResponse {
  final int statusCode;
  final String message;
  final String email;
  final String code;

  RegisterResponse({
    required this.statusCode,
    required this.message,
    required this.email,
    required this.code,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    // Handle nested data structure
    final Map<String, dynamic>? data =
        json['data'] != null ? Map<String, dynamic>.from(json['data']) : null;

    return RegisterResponse(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      email: data != null ? data['email'] ?? '' : '',
      code: data != null ? data['code']?.toString() ?? '' : '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'message': message,
      'data': {
        'email': email,
        'code': code,
      }
    };
  }
}

class BaseResponse<T> {
  final int statusCode;
  final String message;
  final T data;

  BaseResponse({
    required this.data,
    required this.statusCode,
    required this.message,
  });

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? data) convert,
  ) {
    return BaseResponse(
      data: convert(
        json['data'] as Object?,
      ),
      statusCode: json['success'] as int,
      message: json['message'] as String,
    );
  }
}
