import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BiometricAuthService {
  final LocalAuthentication _localAuth = LocalAuthentication();
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  static const String _tokenKey = 'firebase_auth_token';
  static const String _biometricEnabledKey = 'biometric_enabled';

  // 生体認証が利用可能かチェック
  Future<bool> isBiometricAvailable() async {
    try {
      return await _localAuth.canCheckBiometrics &&
          await _localAuth.isDeviceSupported();
    } catch (e) {
      return false;
    }
  }

  // 生体認証が有効化されているかチェック
  Future<bool> isBiometricEnabled() async {
    final enabled = await _storage.read(key: _biometricEnabledKey);
    return enabled == 'true';
  }

  // 生体認証を実行
  Future<bool> authenticate() async {
    try {
      return await _localAuth.authenticate(
        localizedReason: '生体認証でログインします',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
    } catch (e) {
      return false;
    }
  }

  // トークンを保存
  Future<void> saveAuthToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
    await setBiometricEnabled(true);
  }

  // 保��されたトークンを取得
  Future<String?> getAuthToken() async {
    return await _storage.read(key: _tokenKey);
  }

  // 生体認証の有効/無効を設定
  Future<void> setBiometricEnabled(bool enabled) async {
    await _storage.write(key: _biometricEnabledKey, value: enabled.toString());
    if (!enabled) {
      await _storage.delete(key: _tokenKey);
    }
  }

  // トークンを削除（ログアウト時などに使用）
  Future<void> deleteAuthToken() async {
    await _storage.delete(key: _tokenKey);
    await setBiometricEnabled(false);
  }
}
