abstract class Th {
  static const Map<String, String> strings = {
    // General
    'app_name': 'นับแคลอรี่ด้วย AI',
    'save': 'บันทึก',
    'cancel': 'ยกเลิก',
    'next': 'ถัดไป',
    'back': 'กลับ',
    'confirm': 'ยืนยัน',
    'loading': 'กำลังโหลด...',
    'error': 'เกิดข้อผิดพลาด',
    'retry': 'ลองใหม่',

    // Splash
    'splash_tagline': 'ติดตามอาหารด้วย AI',

    // Onboarding
    'onboarding_title': 'ข้อมูลของคุณ',
    'onboarding_subtitle': 'เพื่อคำนวณแคลอรี่เป้าหมายต่อวัน',
    'field_name': 'ชื่อ',
    'field_name_hint': 'กรอกชื่อของคุณ',
    'field_gender': 'เพศ',
    'gender_male': 'ชาย',
    'gender_female': 'หญิง',
    'field_age': 'อายุ (ปี)',
    'field_age_hint': 'เช่น 25',
    'field_height': 'ส่วนสูง (ซม.)',
    'field_height_hint': 'เช่น 165',
    'field_weight': 'น้ำหนักปัจจุบัน (กก.)',
    'field_weight_hint': 'เช่น 70',
    'field_target_weight': 'น้ำหนักเป้าหมาย (กก.)',
    'field_target_weight_hint': 'เช่น 60',
    'field_activity': 'ระดับกิจกรรม',
    'activity_sedentary': 'นั่งทำงาน (ออกกำลังกายน้อยมาก)',
    'activity_light': 'เบา (ออกกำลังกาย 1-3 วัน/สัปดาห์)',
    'activity_moderate': 'ปานกลาง (ออกกำลังกาย 3-5 วัน/สัปดาห์)',
    'activity_active': 'มาก (ออกกำลังกาย 6-7 วัน/สัปดาห์)',
    'activity_very_active': 'มากมาย (ออกกำลังกายหนักทุกวัน)',
    'onboarding_save': 'คำนวณและเริ่มต้น',
    'validation_required': 'กรุณากรอกข้อมูลนี้',
    'validation_number': 'กรุณากรอกตัวเลขที่ถูกต้อง',

    // Home
    'home_title': 'แคลอรี่วันนี้',
    'home_goal': 'เป้าหมาย',
    'home_consumed': 'กินไปแล้ว',
    'home_remaining': 'เหลืออีก',
    'home_add_food': 'เพิ่มอาหาร',
    'home_todays_food': 'รายการอาหารวันนี้',
    'home_no_food': 'ยังไม่มีรายการอาหาร\nกด + เพื่อเพิ่มอาหาร!',
    'home_kcal': 'กิโลแคลอรี่',
    'home_over_limit': 'เกินเป้าหมาย!',
    'home_settings': 'ตั้งค่า',

    // Food Log
    'food_log_title': 'เพิ่มอาหาร',
    'food_log_choose': 'เลือกวิธีเพิ่มอาหาร',
    'food_log_camera': 'ถ่ายรูป',
    'food_log_gallery': 'เลือกจากคลังรูปภาพ',
    'food_log_analyzing': 'AI กำลังวิเคราะห์อาหาร...',
    'food_log_result_title': 'ผลการวิเคราะห์อาหาร',
    'food_log_food_name': 'ชื่ออาหาร',
    'food_log_calories': 'แคลอรี่',
    'food_log_protein': 'โปรตีน',
    'food_log_carbs': 'คาร์โบไฮเดรต',
    'food_log_fat': 'ไขมัน',
    'food_log_serving': 'ปริมาณ',
    'food_log_confidence': 'ความแม่นยำ',
    'food_log_save_food': 'บันทึกรายการอาหาร',
    'food_log_retake': 'ถ่ายรูปใหม่',
    'food_log_mock_note': '* โหมดทดลอง: ใส่ API key ใน .env เพื่อใช้งานจริง',
    'food_log_error_pickup': 'ไม่สามารถโหลดรูปภาพได้',
    'food_log_error_api': 'วิเคราะห์ไม่สำเร็จ กรุณาลองใหม่',

    // Settings
    'settings_title': 'ตั้งค่า',
    'settings_profile': 'แก้ไขโปรไฟล์',
    'settings_language': 'ภาษา',
    'settings_lang_th': 'ไทย (Thai)',
    'settings_lang_en': 'อังกฤษ (English)',
    'settings_about': 'เกี่ยวกับแอพ',
    'settings_version': 'เวอร์ชัน 1.0.0',

    // Calorie info
    'calorie_bmr': 'อัตราเผาผลาญพื้นฐาน (BMR)',
    'calorie_tdee': 'พลังงานที่ใช้ต่อวัน (TDEE)',
    'calorie_deficit': 'ลดต่อวัน',
    'calorie_goal_info': 'เพื่อลดน้ำหนัก ~0.5 กก./สัปดาห์ เราลดจาก TDEE 500 กิโลแคลอรี่',

    // Units
    'unit_g': 'ก.',
    'unit_kcal': 'กิโลแคลอรี่',
    'unit_cm': 'ซม.',
    'unit_kg': 'กก.',
  };
}
