import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../core/services/storage_service.dart';
import '../../domain/entities/food_entry_entity.dart';

class HomeController extends GetxController {
  final StorageService _storage = Get.find();

  final dailyGoal = 1800.obs;
  final foodEntries = <FoodEntryEntity>[].obs;
  final userName = ''.obs;

  String get todayKey => DateFormat('yyyy-MM-dd').format(DateTime.now());

  int get totalConsumed =>
      foodEntries.fold(0, (sum, e) => sum + e.calories);

  int get remaining => dailyGoal.value - totalConsumed;

  double get progressPercent {
    if (dailyGoal.value == 0) return 0;
    final p = totalConsumed / dailyGoal.value;
    return p.clamp(0.0, 1.0);
  }

  bool get isOverLimit => totalConsumed > dailyGoal.value;

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  void _loadData() {
    dailyGoal.value = _storage.getDailyGoal();
    final profile = _storage.getUserProfile();
    if (profile != null) {
      userName.value = profile['name'] as String? ?? '';
    }
    _loadTodayEntries();
  }

  void _loadTodayEntries() {
    final raw = _storage.getFoodLog(todayKey);
    foodEntries.value = raw.map(FoodEntryEntity.fromJson).toList();
  }

  Future<void> removeFoodEntry(int index) async {
    await _storage.removeFoodEntry(todayKey, index);
    _loadTodayEntries();
  }

  void refreshData() => _loadTodayEntries();

  void openAddFood() {
    Get.toNamed('/add-food')?.then((_) => refreshData());
  }

  void openSettings() {
    _showSettingsSheet();
  }

  void _showSettingsSheet() {
    Get.bottomSheet(
      _SettingsSheet(),
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
  }

  void switchLocale(String localeStr) {
    final parts = localeStr.split('_');
    Get.updateLocale(Locale(parts[0], parts[1]));
    _storage.saveLocale(localeStr);
    Get.back();
  }
}

// Settings bottom sheet widget (inline to keep file count manageable)
class _SettingsSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<HomeController>();
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Text(
            'settings_title'.tr,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text('settings_language'.tr),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _LangButton('TH', () => ctrl.switchLocale('th_TH')),
                const SizedBox(width: 8),
                _LangButton('EN', () => ctrl.switchLocale('en_US')),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.edit_outlined),
            title: Text('settings_profile'.tr),
            onTap: () {
              Get.back();
              Get.toNamed('/onboarding');
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text('settings_about'.tr),
            trailing: Text(
              'settings_version'.tr,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _LangButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _LangButton(this.label, this.onTap);

  @override
  Widget build(BuildContext context) {
    final isCurrent = (label == 'TH' && Get.locale?.languageCode == 'th') ||
        (label == 'EN' && Get.locale?.languageCode == 'en');
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isCurrent ? const Color(0xFF4CAF50) : Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isCurrent ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
