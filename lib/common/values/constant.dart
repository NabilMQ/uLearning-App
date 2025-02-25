import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  static final String storageDeviceOpenFirstTime = dotenv.env['storageDeviceOpenFirstTime'] ?? "";
  static final String storageUserProfileKey = dotenv.env['storageUserProfileKey'] ?? "";
  static final String storageUserTokenKey = dotenv.env['storageUserTokenKey'] ?? "";
  static final String serverApiUrl = dotenv.env['serverApiUrl'] ?? "";
}