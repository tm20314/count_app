import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'KEY1', obfuscate: true)
  static String key1 = _Env.key1;

  @EnviedField(varName: 'KEY2')
  static String key2 = _Env.key2;
}
