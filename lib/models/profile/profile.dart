class Profile {
  final String userID;
  final String username;
  final String email;
  final String fullName;
  final String phoneNumber;

  Profile({
    required this.userID,
    required this.username,
    required this.email,
    required this.fullName,
    required this.phoneNumber,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      userID: json['UserID'] ?? '',
      username: json['Username'] ?? '',
      email: json['Email'] ?? '',
      fullName: json['FullName'] ?? '',
      phoneNumber: json['PhoneNumber'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'UserID': userID,
      'Username': username,
      'Email': email,
      'FullName': fullName,
      'PhoneNumber': phoneNumber,
    };
  }

  Profile copyWith({
    String? userID,
    String? username,
    String? email,
    String? fullName,
    String? phoneNumber,
  }) {
    return Profile(
      userID: userID ?? this.userID,
      username: username ?? this.username,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}
