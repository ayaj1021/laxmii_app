// // ignore_for_file: avoid_positional_boolean_parameters

// import 'dart:io';

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:local_auth/local_auth.dart';

// class Biometrics {
//   Biometrics(this.localAuthentication);
//   final LocalAuthentication localAuthentication;
//  // final LocalStorage keyValueStore;

//   Future<BiometricType?> getAvailableBiometrics() async {
//     final availableBiometrics =
//         await localAuthentication.getAvailableBiometrics();
//     if (availableBiometrics.isEmpty) return null;
//     if (Platform.isIOS) {
//       if (availableBiometrics.contains(BiometricType.face)) {
//         return BiometricType.face;
//       } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
//         // Touch ID.
//         return BiometricType.fingerprint;
//       } else {
//         return availableBiometrics.first;
//       }
//     } else {
//       // Android FingerPrint
//       return BiometricType.fingerprint;
//     }
//   }

//   Future<bool> canDoBiometrics() async {
//     final canDoBiometrics = await localAuthentication.canCheckBiometrics;
//     final isDeviceSupported = await localAuthentication.isDeviceSupported();
//     return canDoBiometrics && isDeviceSupported;
//   }

//   Future<bool> performAuth(String v) async {
//     try {
//       final didAuthenticate = await localAuthentication.authenticate(
//         localizedReason: v,
//       );
//       return didAuthenticate;
//     } catch (e) {
//       return false;
//     }
//   }

//   Future<bool> stopAuthentication() async {
//     return localAuthentication.stopAuthentication();
//   }

//   // bool get enabledBiometrics =>
//   //     keyValueStore.get(HiveKeys.enabledBiometrics) as bool? ?? false;

//   // Future<void> setBiometric(bool val) async => keyValueStore.put(
//   //       HiveKeys.enabledBiometrics,
//   //       val,
//   //     );
// }

// final biometricsProvider = Provider<Biometrics>(
//   (ref) => Biometrics(
//     LocalAuthentication(),
//     //ref.read(localStorageProvider),
//   ),
// );

// import 'package:flutter/material.dart';
// import 'package:local_auth/local_auth.dart';

// class LocalAuth {
//   static final _auth = LocalAuthentication();

//   static Future<bool> canAuthenticate() async {
//     try {
//       return await _auth.isDeviceSupported() || await _auth.canCheckBiometrics;
//     } catch (e) {
//       return false;
//     }
//   }

//   static Future<bool> authenticate() async {
//     try {
//       if (!await canAuthenticate()) {
//         return false;
//       }
//       return await _auth.authenticate(
//         // authMessages: <AuthMessages>[
//         //   const AndroidAuthMessages(
//         //     signInTitle: 'Authentication Required',
//         //     cancelButton: 'Cancel',
//         //   ),
//         //   const IOSAuthMessages(
//         //     cancelButton: 'Cancel',
//         //     goToSettingsButton: 'Settings',
//         //     goToSettingsDescription: 'Please enable biometrics in settings.',
//         //   ),
//         // ],
//         localizedReason: 'Please authenticate to sign in',
//         options: const AuthenticationOptions(
//           useErrorDialogs: true,
//           stickyAuth: true,
//         ),
//       );
//     } catch (e) {
//       debugPrint('Authentication error: $e');
//       return false;
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuth {
  static final _auth = LocalAuthentication();

  static Future<bool> canAuthenticate() async {
    try {
      final isDeviceSupported = await _auth.isDeviceSupported();
      final canCheckBiometrics = await _auth.canCheckBiometrics;
      final biometrics = await _auth.getAvailableBiometrics();
      debugPrint('isDeviceSupported: $isDeviceSupported');
      debugPrint('canCheckBiometrics: $canCheckBiometrics');
      debugPrint('Available biometrics: $biometrics');
      return isDeviceSupported && canCheckBiometrics && biometrics.isNotEmpty;
    } catch (e) {
      debugPrint('canAuthenticate error: $e');
      return false;
    }
  }

  static Future<bool> authenticate() async {
    try {
      if (!await canAuthenticate()) {
        debugPrint('Biometrics not available or not enrolled.');
        return false;
      }
      return await _auth.authenticate(
        localizedReason: 'Please authenticate to sign in',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
    } catch (e) {
      debugPrint('Authentication error: $e');
      return false;
    }
  }
}
