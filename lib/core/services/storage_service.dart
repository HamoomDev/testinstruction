import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';

class StorageService extends GetxService {
  late SharedPreferences _prefs;

  Future<StorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  // User Profile
  Future<void> saveUserProfile(Map<String, dynamic> profile) async {
    await _prefs.setString(AppConstants.keyUserProfile, jsonEncode(profile));
  }

  Map<String, dynamic>? getUserProfile() {
    final raw = _prefs.getString(AppConstants.keyUserProfile);
    if (raw == null) return null;
    return jsonDecode(raw) as Map<String, dynamic>;
  }

  bool get hasUserProfile => _prefs.containsKey(AppConstants.keyUserProfile);

  // Daily Calorie Goal
  Future<void> saveDailyGoal(int calories) async {
    await _prefs.setInt(AppConstants.keyDailyCalorieGoal, calories);
  }

  int getDailyGoal() => _prefs.getInt(AppConstants.keyDailyCalorieGoal) ?? 1800;

  // Food Log (keyed by date: yyyy-MM-dd)
  Future<void> saveFoodLog(String date, List<Map<String, dynamic>> entries) async {
    await _prefs.setString('${AppConstants.keyFoodLog}$date', jsonEncode(entries));
  }

  List<Map<String, dynamic>> getFoodLog(String date) {
    final raw = _prefs.getString('${AppConstants.keyFoodLog}$date');
    if (raw == null) return [];
    final list = jsonDecode(raw) as List;
    return list.cast<Map<String, dynamic>>();
  }

  Future<void> addFoodEntry(String date, Map<String, dynamic> entry) async {
    final current = getFoodLog(date);
    current.add(entry);
    await saveFoodLog(date, current);
  }

  Future<void> removeFoodEntry(String date, int index) async {
    final current = getFoodLog(date);
    if (index >= 0 && index < current.length) {
      current.removeAt(index);
      await saveFoodLog(date, current);
    }
  }

  // Locale
  Future<void> saveLocale(String locale) async {
    await _prefs.setString(AppConstants.keyLocale, locale);
  }

  String getLocale() => _prefs.getString(AppConstants.keyLocale) ?? 'th_TH';
}
