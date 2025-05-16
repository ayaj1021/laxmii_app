import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/login/data/model/get_user_details_response.dart';
import 'package:laxmii_app/presentation/features/manage_account/data/model/update_profile_response.dart';

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
  Future<void> saveRememberMe(bool value) async {
    await _storage.write(key: 'remember_me', value: value.toString());
  }

// Retrieve the boolean value
  Future<bool> getRememberMe() async {
    final value = await _storage.read(key: 'remember_me');
    return value == 'true'; // Convert the string back to a boolean
  }

  Future<void> setAppTheme(bool value) async {
    await _storage.write(key: 'app_theme', value: value.toString());
  }

// Retrieve the boolean value
  Future<bool> getAppTheme() async {
    final value = await _storage.read(key: 'app_theme');
    return value == 'true'; // Convert the string back to a boolean
  }

  Future<void> saveProfileSetup(bool value) async {
    await _storage.write(key: 'profile_setup', value: value.toString());
  }

// Retrieve the boolean value
  Future<bool> getProfileSetup() async {
    final value = await _storage.read(key: 'profile_setup');
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

  Future<void> storeProfile(UpdateProfileResponse profileResponse) async {
    final String jsonString = jsonEncode(profileResponse.toJson());
    await _storage.write(key: 'user_profile', value: jsonString);
  }

  Future<UpdateProfileResponse?> getStoredProfile() async {
    final String? jsonString = await _storage.read(key: 'user_profile');

    if (jsonString == null) return null;

    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    return UpdateProfileResponse.fromJson(jsonMap);
  }

  Future<void> storUserDetails(GetUserDetailsResponse profileResponse) async {
    final String jsonString = jsonEncode(profileResponse.toJson());
    await _storage.write(key: 'user_details', value: jsonString);
  }

  Future<GetUserDetailsResponse?> getUserDetails() async {
    final String? jsonString = await _storage.read(key: 'user_details');

    if (jsonString == null) return null;

    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    return GetUserDetailsResponse.fromJson(jsonMap);
  }

  Future<void> clearToken() async {
    await _storage.delete(key: 'token');
    await _storage.delete(key: 'user_account_name');
    await _storage.delete(key: 'access_token');
    await _storage.delete(key: 'refresh_token');
    await _storage.delete(key: 'remember_me');
  }

  Future<void> clearStoredPin() async {
    await _storage.delete(key: 'user_pin');
  }

  Future<void> saveResetPasswordToken(String token) async {
    await _storage.write(key: 'token', value: token);
  }

  Future<String?> getResetPasswordToken() async {
    String? value = await _storage.read(key: 'token');
    return value;
  }

  Future<void> saveUserId(String id) async {
    await _storage.write(key: 'id', value: id);
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

  Future<void> saveIsPinSet(bool value) async {
    await _storage.write(key: 'pin_set', value: value.toString());
  }

// Retrieve the boolean value
  Future<bool> getIsPinSet() async {
    final value = await _storage.read(key: 'pin_set');
    return value == 'true'; // Convert the string back to a boolean
  }

  Future<void> setEnablePin(bool value) async {
    await _storage.write(key: 'enable_pin', value: value.toString());
  }

// Retrieve the boolean value
  Future<bool> getEnablePin() async {
    final value = await _storage.read(key: 'enable_pin');
    return value == 'true'; // Convert the string back to a boolean
  }

  Future<void> saveUserAccountName(String userAccountName) async {
    await _storage.write(key: 'user_account_name', value: userAccountName);
  }

  Future<String?> getUserAccountName() async {
    String? value = await _storage.read(key: 'user_account_name');
    return value;
  }

  Future<void> saveUserAccountEmail(String userEmail) async {
    await _storage.write(key: 'user_email', value: userEmail);
  }

  Future<String?> getUserAccountEmail() async {
    String? value = await _storage.read(key: 'user_email');
    return value;
  }

  Future<void> saveReferralLink(String userEmail) async {
    await _storage.write(key: 'referral_link', value: userEmail);
  }

  Future<String?> getReferralLink() async {
    String? value = await _storage.read(key: 'referral_link');
    return value;
  }

  Future<void> saveUserCurrency(String userCurrency) async {
    await _storage.write(key: 'user_currency', value: userCurrency);
  }

  Future<String?> getUserCurrency() async {
    String? value = await _storage.read(key: 'user_currency');
    return value;
  }

  Future<void> saveUserImage(String userImage) async {
    await _storage.write(key: 'user_image', value: userImage);
  }

  Future<String?> getUserImage() async {
    String? value = await _storage.read(key: 'user_image');
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

  Future<CurrentState> loadCurrentState() async {
    final stateString =
        await _storage.read(key: "currentState") ?? CurrentState.initial.name;
    switch (stateString) {
      case 'onboarded':
        return CurrentState.onboarded;

      case 'loggedIn':
        return CurrentState.loggedIn;

      default:
        return CurrentState.initial;
    }
  }

  Future<void> saveCurrentState(CurrentState val) async {
    await _storage.write(key: "currentState", value: val.name);
  }

  Future<void> logout({
    bool partialLogout = false,
  }) async {
    if (partialLogout) {
      await clearToken();
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
