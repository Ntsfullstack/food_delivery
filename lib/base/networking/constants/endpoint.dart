class Endpoints {
  Endpoints._();
  static const String login = "/api/users/login";
  static const String register = "/api/users/register";
  static const String profile = "/api/users/me";
  static const String updateProfile = "/api/users/me";
  static const String changePassword = "/api/users/change-password";
  static const String logout = "/api/users/logout";
  static const String refreshToken = "/api/users/refresh-token";
  static const String verifyEmail = "/api/users/verify-registration";
  static const String resendEmailVerification = "/api/users/resend-email-verification";
  static const String getListDishes = "/api/dishes";
  static const String getAllUsers = "/api/admin/users";
  static const String updateUsers = "/api/admin/users";
  static const String deleteUser = "/api/users";
  static const String listDishes ="/api/dishes";
  static const String dashBoard = "/api/admin/dashboard/stats";
}

