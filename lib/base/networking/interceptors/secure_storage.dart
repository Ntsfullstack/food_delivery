// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//
// SecureStorage secStore = new SecureStorage();
//
// class SecureStorage {
//   final _storage = FlutterSecureStorage();
//   void addNewItem(String key, String value) async {
//     await _storage.write(
//       key: key,
//       value: value,
//       iOptions: _getIOSOptions(),
//     );
//   }
//
//   IOSOptions _getIOSOptions() => IOSOptions(
//     accountName: _getAccountName(),
//   );
//
//   String _getAccountName() => 'blah_blah_blah';
//
//   Future<String?> secureRead(String key) async {
//     String? value = await _storage.read(key: key);
//     return value;
//   }
//
//   Future<void> secureDelete(String key) async {
//     await _storage.delete(key: key);
//   }
//
//   Future<void> secureWrite(String key, String value) async {
//     await _storage.write(key: key, value: value);
//   }
// }