abstract class AppConstants {
  static const String apiBaseUrl = 'https://api.anthropic.com/v1/messages';
  static const String claudeModel = 'claude-haiku-4-5-20251001';
  static const String apiVersion = '2023-06-01';

  // SharedPreferences keys
  static const String keyUserProfile = 'user_profile';
  static const String keyFoodLog = 'food_log_';
  static const String keyLocale = 'locale';
  static const String keyDailyCalorieGoal = 'daily_calorie_goal';

  // Calorie deficit for weight loss (kcal/day)
  static const int calorieDeficit = 500;

  // Activity factors (Mifflin-St Jeor)
  static const Map<String, double> activityFactors = {
    'sedentary': 1.2,
    'light': 1.375,
    'moderate': 1.55,
    'active': 1.725,
    'very_active': 1.9,
  };
}
