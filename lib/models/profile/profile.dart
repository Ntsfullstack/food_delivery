class Profile {
  final String userID;
  final String username;
  final String email;
  final String fullName;
  final String phoneNumber;
  final String role;
  final String address;
  final String? walletBalance;
  final String referralCode;

  Profile({
    required this.userID,
    required this.username,
    required this.email,
    required this.fullName,
    required this.phoneNumber,
    required this.role,
    required this.address,
    this.walletBalance,
    required this.referralCode,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    // Kiểm tra xem json có chứa 'data' không
    final data = json.containsKey('data') ? json['data'] : json;

    return Profile(
      userID: data['userId'] ?? '',
      username: data['username'] ?? '',
      email: data['email'] ?? '',
      fullName: data['fullName'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      role: data['role'] ?? '',
      address: data['address'] ?? '',
      walletBalance: data['walletBalance'],
      referralCode: data['referralCode'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userID,
      'username': username,
      'email': email,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'role': role,
      'address': address,
      'walletBalance': walletBalance,
      'referralCode': referralCode,
    };
  }

  Profile copyWith({
    String? userID,
    String? username,
    String? email,
    String? fullName,
    String? phoneNumber,
    String? role,
    String? address,
    String? walletBalance,
    String? referralCode,
  }) {
    return Profile(
      userID: userID ?? this.userID,
      username: username ?? this.username,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      address: address ?? this.address,
      walletBalance: walletBalance ?? this.walletBalance,
      referralCode: referralCode ?? this.referralCode,
    );
  }

  @override
  String toString() {
    return 'Profile(userID: $userID, username: $username, email: $email, fullName: $fullName, phoneNumber: $phoneNumber, role: $role, address: $address, walletBalance: $walletBalance, referralCode: $referralCode)';
  }
}
