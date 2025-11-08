import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: 'lib/core/app_secured_data/.env', obfuscate: true)
abstract class Env {
  @EnviedField(varName: 'BASE_DEV_URL', obfuscate: true)
  static final String baseDevUrl = _Env.baseDevUrl;
}
