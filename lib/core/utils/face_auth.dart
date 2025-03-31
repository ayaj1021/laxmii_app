// import 'dart:developer';

// import 'package:flutter/services.dart';
// import 'package:local_auth/local_auth.dart';

// class LocalAuthApi {
//   static final _auth = LocalAuthentication();

//   Future<bool> hasBiometrics() async {
//     try {
//       List<BiometricType> availableBiometrics =
//           await _auth.getAvailableBiometrics();
//       log('Lis of avaiable biometrics ${availableBiometrics.toString()}');
//       return await _auth.canCheckBiometrics;
//     } on PlatformException catch (e) {
//       log(e.toString());
//       return false;
//     }
//   }

//   Future<bool> authenticate() async {
//     final isAvailable = await hasBiometrics();
//     if (!isAvailable) {
//       return false;
//     }
//     try {
//       return await _auth.authenticate(
//           // authMessages:[  AndroidAuthMessages(
//           //   cancelButton: 'Cancel',
//           //   goToSettingsButton: 'Settings',
//           //   goToSettingsDescription: 'Please set up your biometrics.',
//           //   biometricHint: 'Biometric',
//           //   signInTitle: 'Biometric Authentication',
//           //   fingerprintNotRecognized: 'Fingerprint not recognized',
//           //   fingerprintSuccess: 'Fingerprint recognized',
//           //   fingerprintHint: 'Touch sensor',
//           //   fingerprintRequiredTitle: 'Biometric authentication required',
//           //   deviceCredentialsRequiredTitle: 'Biometric authentication required',
//           // ),],
//           localizedReason: 'Please scan to authenticate',
//           options: const AuthenticationOptions(
//             useErrorDialogs: true,
//             stickyAuth: true,
//             biometricOnly: true,
//           ));
//     } on PlatformException catch (e) {
//       log(e.toString());
//       return false;
//     }
//   }
// }

import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthApi {
  static final _auth = LocalAuthentication();

  Future<bool> hasBiometrics() async {
    try {
      List<BiometricType> availableBiometrics =
          await _auth.getAvailableBiometrics();
      log('List of available biometrics: ${availableBiometrics.toString()}');
      final canCheckBiometrics = await _auth.canCheckBiometrics;
      log('Can check biometrics: $canCheckBiometrics');
      return canCheckBiometrics && availableBiometrics.isNotEmpty;
    } on PlatformException catch (e) {
      log('Error checking biometrics: ${e.toString()}');
      return false;
    }
  }

  Future<bool> authenticate() async {
    final isAvailable = await hasBiometrics();
    if (!isAvailable) {
      log('Biometrics not available or not enrolled');
      return false;
    }
    try {
      final isAuthenticated = await _auth.authenticate(
        localizedReason: 'Please scan to authenticate',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
          biometricOnly: false, // Allow fallback to device credentials
        ),
      );
      log('Authentication result: $isAuthenticated');
      return isAuthenticated;
    } on PlatformException catch (e) {
      log('Authentication failed: ${e.message}');
      return false;
    }
  }
}
