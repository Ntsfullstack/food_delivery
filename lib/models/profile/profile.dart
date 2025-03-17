class Profile {
  final String userID;
  final String username;
  final String email;
  final String fullName;
  final String phoneNumber;
  final String role;

  Profile({
    required this.userID,
    required this.username,
    required this.email,
    required this.fullName,
    required this.phoneNumber,
    required this.role
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    // Kiểm tra xem json có chứa 'data' không
    final data = json.containsKey('data') ? json['data'] : json;

    return Profile(
      userID: data['userId'] ?? '',       // Thay 'UserID' thành 'userId'
      username: data['username'] ?? '',   // Thay 'Username' thành 'username'
      email: data['email'] ?? '',         // Thay 'Email' thành 'email'
      fullName: data['fullName'] ?? '',   // Thay 'FullName' thành 'fullName'
      phoneNumber: data['phoneNumber'] ?? '',
      role: data['role'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userID,        // Cập nhật key ở đây cũng để đồng bộ
      'username': username,
      'email': email,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'role': role,
    };
  }

  Profile copyWith({
    String? userID,
    String? username,
    String? email,
    String? fullName,
    String? phoneNumber,
    String? role,
  }) {
    return Profile(
      userID: userID ?? this.userID,
      username: username ?? this.username,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role
    );
  }

  @override
  String toString() {
    return 'Profile(userID: $userID, username: $username, email: $email, fullName: $fullName, phoneNumber: $phoneNumber, role: $role)';
  }
}