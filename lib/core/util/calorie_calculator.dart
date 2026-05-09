import '../constants/app_constants.dart';

class CalorieCalculator {
  // Mifflin-St Jeor BMR formula
  static double calculateBMR({
    required double weightKg,
    required double heightCm,
    required int age,
    required bool isMale,
  }) {
    final base = (10 * weightKg) + (6.25 * heightCm) - (5 * age);
    return isMale ? base + 5 : base - 161;
  }

  static double calculateTDEE({
    required double bmr,
    required String activityLevel,
  }) {
    final factor = AppConstants.activityFactors[activityLevel] ?? 1.2;
    return bmr * factor;
  }

  // Daily calorie goal for weight loss (TDEE - 500 kcal deficit)
  static int calculateDailyGoal({
    required double weightKg,
    required double heightCm,
    required int age,
    required bool isMale,
    required String activityLevel,
  }) {
    final bmr = calculateBMR(
      weightKg: weightKg,
      heightCm: heightCm,
      age: age,
      isMale: isMale,
    );
    final tdee = calculateTDEE(bmr: bmr, activityLevel: activityLevel);
    final goal = tdee - AppConstants.calorieDeficit;
    // Never go below 1200 kcal (health minimum)
    return goal < 1200 ? 1200 : goal.round();
  }

  static Map<String, double> getCalorieBreakdown({
    required double weightKg,
    required double heightCm,
    required int age,
    required bool isMale,
    required String activityLevel,
  }) {
    final bmr = calculateBMR(
      weightKg: weightKg,
      heightCm: heightCm,
      age: age,
      isMale: isMale,
    );
    final tdee = calculateTDEE(bmr: bmr, activityLevel: activityLevel);
    final goal = (tdee - AppConstants.calorieDeficit).clamp(1200, double.infinity);
    return {
      'bmr': bmr,
      'tdee': tdee,
      'goal': goal,
      'deficit': AppConstants.calorieDeficit.toDouble(),
    };
  }
}
