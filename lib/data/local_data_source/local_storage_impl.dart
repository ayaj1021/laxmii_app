import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppDataStorage {
  AppDataStorage._();

  // Singleton instance
  static final AppDataStorage _instance = AppDataStorage._();

  // Factory constructor to return the same instance every time
  factory AppDataStorage() => _instance;

  final _storage = const FlutterSecureStorage(

      // iOptions: IOSOptions.defaultOptions,
      // aOptions: AndroidOptions.defaultOptions,
      );

  Future<void> saveUserEmail(String userEmail) async {
    await _storage.write(key: 'user_email', value: userEmail);
  }

  Future<String?> getUserEmail() async {
    String? value = await _storage.read(key: 'user_email');
    return value;
  }

  Future<void> saveUserForgotPasswordCode(String userEmail) async {
    await _storage.write(key: 'code', value: userEmail);
  }

  Future<String?> getUserForgotPasswordCode() async {
    String? value = await _storage.read(key: 'code');
    return value;
  }

  Future<void> saveUserFirstName(String userEmail) async {
    await _storage.write(key: 'firstName', value: userEmail);
  }

  Future<String?> getUserFirstName() async {
    String? value = await _storage.read(key: 'firstName');
    return value;
  }

  Future<void> saveUserPassword(String userPassword) async {
    await _storage.write(key: 'user_password', value: userPassword);
  }

  Future<String?> getUserPassword() async {
    String? value = await _storage.read(key: 'user_password');
    return value;
  }

  Future<void> saveUserAccessToken(String token) async {
    await _storage.write(key: 'access_token', value: token);
  }

  Future<String?> getUserAccessToken() async {
    String? value = await _storage.read(key: 'access_token');
    return value;
  }

  Future<void> saveUserRefreshToken(String token) async {
    await _storage.write(key: 'refresh_token', value: token);
  }

  Future<String?> getUserRefreshToken() async {
    String? value = await _storage.read(key: 'refresh_token');
    return value;
  }

  Future<void> saveUserAccountNumber(String token) async {
    await _storage.write(key: 'account_number', value: token);
  }

  Future<String?> getUserAccountNumber() async {
    String? value = await _storage.read(key: 'account_number');
    return value;
  }

  // Store a boolean value
  Future<void> saveRememberMe(String key, bool value) async {
    await _storage.write(key: key, value: value.toString());
  }

// Retrieve the boolean value
  Future<bool> getRememberMe(String key) async {
    final value = await _storage.read(key: key);
    return value == 'true'; // Convert the string back to a boolean
  }

  Future<void> saveUserToken(String token) async {
    await _storage.write(key: 'token', value: token);
  }

  Future<String?> getUserToken() async {
    String? value = await _storage.read(key: 'token');
    return value;
  }

  Future<void> saveUserFirebaseToken(String token) async {
    await _storage.write(key: 'firebase_token', value: token);
  }

  Future<String?> getUserFirebaseToken() async {
    String? value = await _storage.read(key: 'firebase_token');
    return value;
  }

  Future<void> clearToken() async {
    await _storage.delete(key: 'token');
    await _storage.delete(key: 'user_account_name');
    await _storage.delete(key: 'access_token');
    await _storage.delete(key: 'refresh_token');
    await _storage.delete(key: 'remember_me');
  }

  Future<void> saveResetPasswordToken(String token) async {
    await _storage.write(key: 'token', value: token);
  }

  Future<String?> getResetPasswordToken() async {
    String? value = await _storage.read(key: 'token');
    return value;
  }

  Future<void> saveUserId(int id) async {
    await _storage.write(key: 'id', value: id.toString());
  }

  Future<String?> getUserId() async {
    String? value = await _storage.read(key: 'id');
    return value;
  }

  Future<void> saveUserPin(String userPin) async {
    await _storage.write(key: 'user_pin', value: userPin);
  }

  Future<String?> getUserPin() async {
    String? value = await _storage.read(key: 'user_pin');
    return value;
  }

  Future<void> saveUserAccountName(String userEmail) async {
    await _storage.write(key: 'user_account_name', value: userEmail);
  }

  Future<String?> getUserAccountName() async {
    String? value = await _storage.read(key: 'user_account_name');
    return value;
  }

  Future<void> saveReferralLink(String userEmail) async {
    await _storage.write(key: 'referral_link', value: userEmail);
  }

  Future<String?> getReferralLink() async {
    String? value = await _storage.read(key: 'referral_link');
    return value;
  }

  Future<void> deleteTransactionDataList() async {
    await _storage.delete(key: 'transaction_data_list');
  }

  // Future<void> saveUserDetails(
  //     AccountOwnerProfileData accountOwnerProfileData) async {
  //   String jsonString = jsonEncode(accountOwnerProfileData.toJson());
  //   await _storage.write(key: 'user_details', value: jsonString);
  // }

  // Future<AccountOwnerProfileData?> getUserDetails() async {
  //   String? jsonString = await _storage.read(key: 'user_details');
  //   if (jsonString != null) {
  //     Map<String, dynamic> jsonMap = jsonDecode(jsonString);
  //     return AccountOwnerProfileData.fromJson(jsonMap);
  //   }
  //   return null;
  // }

  Future<void> logout({
    bool partialLogout = false,
  }) async {
    if (partialLogout) {
      await clearToken();
      return;
    }
    //  await _localStorage.clear();
    // await saveCurrentState(CurrentState.onboarded);
  }
}

final localStorageProvider = Provider<AppDataStorage>(
  (ref) => AppDataStorage(),
);
