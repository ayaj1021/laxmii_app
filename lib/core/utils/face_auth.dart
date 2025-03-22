import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthApi {
  static final _auth = LocalAuthentication();

  Future<bool> hasBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> authenticate() async {
    final isAvailable = await hasBiometrics();
    if (!isAvailable) {
      return false;
    }
    try {
      return await _auth.authenticate(
          // authMessages:[  AndroidAuthMessages(
          //   cancelButton: 'Cancel',
          //   goToSettingsButton: 'Settings',
          //   goToSettingsDescription: 'Please set up your biometrics.',
          //   biometricHint: 'Biometric',
          //   signInTitle: 'Biometric Authentication',
          //   fingerprintNotRecognized: 'Fingerprint not recognized',
          //   fingerprintSuccess: 'Fingerprint recognized',
          //   fingerprintHint: 'Touch sensor',
          //   fingerprintRequiredTitle: 'Biometric authentication required',
          //   deviceCredentialsRequiredTitle: 'Biometric authentication required',
          // ),],
          localizedReason: 'Please scan to authenticate',
          options: const AuthenticationOptions(
              useErrorDialogs: true, stickyAuth: true)
          // useErrorDialogs: true,
          // stickyAuth: true,
          );
    } on PlatformException catch (e) {
      log(e.toString());
      return false;
    }
  }
}
