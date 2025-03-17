class Users {
  final String userId;
  final String username;
  final String email;
  final String fullName;
  final String phoneNumber;
  final String role;
  final String? referralCode;
  final double? walletBalance;

  Users({
    required this.userId,
    required this.username,
    required this.email,
    required this.fullName,
    required this.phoneNumber,
    required this.role,
    this.referralCode,
    this.walletBalance,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      userId: json['userId'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      fullName: json['fullName'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      role: json['role'] ?? 'customer',
      referralCode: json['referralCode'],
      walletBalance: json['walletBalance'] != null
          ? (json['walletBalance'] is num
          ? json['walletBalance'].toDouble()
          : double.tryParse(json['walletBalance'].toString()) ?? 0.0)
          : 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'username': username,
      'email': email,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'role': role,
      'referralCode': referralCode,
      'walletBalance': walletBalance,
    };
  }
}