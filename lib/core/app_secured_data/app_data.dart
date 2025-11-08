import 'package:find_me_app/core/app_secured_data/env.dart';
import 'package:find_me_app/core/di.dart';
import 'package:find_me_app/features/auth/data/source/auth_local.dart';

enum AppEnvironments { dev, prod }

class AppEnvironmentData {
  late String _baseUrl;

  String get baseUrl => _baseUrl;

  Future<void> init(AppEnvironments serverVersion) async {
    // مباشرة من .env للتأكد من عدم تكرار /api
    _baseUrl = Env.baseDevUrl;
  }

  void setNewUrl(String url) {
    _baseUrl = url;
  }
}
