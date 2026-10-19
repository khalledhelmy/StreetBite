import 'package:local_auth/local_auth.dart';

class BiometricService {
  final LocalAuthentication _localAuth = LocalAuthentication();

  Future<bool> authenticate({required String localizedReason}) async {
    final isSupported = await _localAuth.isDeviceSupported();
    final canCheckBiometrics = await _localAuth.canCheckBiometrics;

    if (!isSupported || !canCheckBiometrics) {
      throw StateError(
        'This device does not support biometric authentication.',
      );
    }

    final availableBiometrics = await _localAuth.getAvailableBiometrics();

    if (availableBiometrics.isEmpty) {
      throw StateError(
        'No biometrics are enrolled. Set up a fingerprint or face ID in device settings.',
      );
    }

    return _localAuth.authenticate(
      localizedReason: localizedReason,
      biometricOnly: true,
      persistAcrossBackgrounding: true,
    );
  }
}
