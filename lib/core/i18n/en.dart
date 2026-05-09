abstract class En {
  static const Map<String, String> strings = {
    // General
    'app_name': 'Calorie Counter AI',
    'save': 'Save',
    'cancel': 'Cancel',
    'next': 'Next',
    'back': 'Back',
    'confirm': 'Confirm',
    'loading': 'Loading...',
    'error': 'Error',
    'retry': 'Retry',

    // Splash
    'splash_tagline': 'Track your food with AI',

    // Onboarding
    'onboarding_title': 'Your Profile',
    'onboarding_subtitle': 'Help us calculate your daily calorie goal',
    'field_name': 'Name',
    'field_name_hint': 'Enter your name',
    'field_gender': 'Gender',
    'gender_male': 'Male',
    'gender_female': 'Female',
    'field_age': 'Age (years)',
    'field_age_hint': 'e.g. 25',
    'field_height': 'Height (cm)',
    'field_height_hint': 'e.g. 165',
    'field_weight': 'Current Weight (kg)',
    'field_weight_hint': 'e.g. 70',
    'field_target_weight': 'Target Weight (kg)',
    'field_target_weight_hint': 'e.g. 60',
    'field_activity': 'Activity Level',
    'activity_sedentary': 'Sedentary (little or no exercise)',
    'activity_light': 'Light (1-3 days/week)',
    'activity_moderate': 'Moderate (3-5 days/week)',
    'activity_active': 'Active (6-7 days/week)',
    'activity_very_active': 'Very Active (intense daily exercise)',
    'onboarding_save': 'Calculate & Start',
    'validation_required': 'This field is required',
    'validation_number': 'Please enter a valid number',

    // Home
    'home_title': 'Today\'s Calories',
    'home_goal': 'Daily Goal',
    'home_consumed': 'Consumed',
    'home_remaining': 'Remaining',
    'home_add_food': 'Add Food',
    'home_todays_food': 'Today\'s Food Log',
    'home_no_food': 'No food logged yet.\nTap + to add food!',
    'home_kcal': 'kcal',
    'home_over_limit': 'Over limit!',
    'home_settings': 'Settings',

    // Food Log
    'food_log_title': 'Add Food',
    'food_log_choose': 'How would you like to add food?',
    'food_log_camera': 'Take Photo',
    'food_log_gallery': 'Choose from Gallery',
    'food_log_analyzing': 'AI is analyzing your food...',
    'food_log_result_title': 'Food Analysis Result',
    'food_log_food_name': 'Food',
    'food_log_calories': 'Calories',
    'food_log_protein': 'Protein',
    'food_log_carbs': 'Carbs',
    'food_log_fat': 'Fat',
    'food_log_serving': 'Serving',
    'food_log_confidence': 'Confidence',
    'food_log_save_food': 'Save to Log',
    'food_log_retake': 'Retake Photo',
    'food_log_mock_note': '* Mock mode: Set your API key in .env file',
    'food_log_error_pickup': 'Could not load image',
    'food_log_error_api': 'Analysis failed. Please try again.',

    // Settings (inside Home)
    'settings_title': 'Settings',
    'settings_profile': 'Edit Profile',
    'settings_language': 'Language',
    'settings_lang_th': 'Thai (ภาษาไทย)',
    'settings_lang_en': 'English',
    'settings_about': 'About',
    'settings_version': 'Version 1.0.0',

    // Calorie info
    'calorie_bmr': 'BMR',
    'calorie_tdee': 'TDEE',
    'calorie_deficit': 'Daily Deficit',
    'calorie_goal_info': 'To lose ~0.5 kg/week, we set a 500 kcal deficit from your TDEE.',

    // Units
    'unit_g': 'g',
    'unit_kcal': 'kcal',
    'unit_cm': 'cm',
    'unit_kg': 'kg',
  };
}
