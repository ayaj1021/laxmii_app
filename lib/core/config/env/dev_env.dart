


import 'package:laxmii_app/core/config/env/base_env.dart';


class DevEnv implements BaseEnv {
  factory DevEnv() => _instance;
  DevEnv._internal();
  static final DevEnv _instance = DevEnv._internal();
  @override
  String get baseUrl => 'http://localhost:3000';
  //String get baseUrl => 'https://digit-send-backend.onrender.com';
}
