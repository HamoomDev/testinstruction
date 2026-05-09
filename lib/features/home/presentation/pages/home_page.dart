import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_theme.dart';
import '../controllers/home_controller.dart';
import '../widgets/calorie_ring_widget.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
              controller.userName.value.isEmpty
                  ? 'home_title'.tr
                  : '${'home_title'.tr} 👋 ${controller.userName.value}',
            )),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: controller.openSettings,
          ),
        ],
      ),
      body: Obx(() => RefreshIndicator(
            onRefresh: () async => controller.refreshData(),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                CalorieRingWidget(
                  consumed: controller.totalConsumed,
                  goal: controller.dailyGoal.value,
                  remaining: controller.remaining,
                  percent: controller.progressPercent,
                  isOver: controller.isOverLimit,
                ),
                const SizedBox(height: 16),
                _calorieGoalInfo(),
                const SizedBox(height: 20),
                _foodLogSection(),
              ],
            ),
          )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: controller.openAddFood,
        icon: const Icon(Icons.add_a_photo),
        label: Text('home_add_food'.tr),
      ),
    );
  }

  Widget _calorieGoalInfo() {
    return Obx(() => Card(
          color: AppColors.primary.withValues(alpha: 0.08),
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                const Icon(Icons.local_fire_department, color: AppColors.secondary, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${'home_goal'.tr}: ${controller.dailyGoal.value} ${'unit_kcal'.tr}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: AppColors.primaryDark,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'calorie_goal_info'.tr,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _foodLogSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'home_todays_food'.tr,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        Obx(() {
          if (controller.foodEntries.isEmpty) {
            return _emptyState();
          }
          return Column(
            children: controller.foodEntries.asMap().entries.map((e) {
              return _foodEntryCard(e.value, e.key);
            }).toList(),
          );
        }),
      ],
    );
  }

  Widget _emptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          Icon(Icons.no_food, size: 64, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            'home_no_food'.tr,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[400], fontSize: 15),
          ),
        ],
      ),
    );
  }

  Widget _foodEntryCard(dynamic entry, int index) {
    final isTh = Get.locale?.languageCode == 'th';
    final name = isTh ? entry.foodNameTh : entry.foodName;
    final time = DateFormat('HH:mm').format(entry.loggedAt);

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.restaurant, color: AppColors.primary, size: 22),
        ),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          '${entry.servingSize} • $time',
          style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${entry.calories}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            Text(
              'unit_kcal'.tr,
              style: const TextStyle(fontSize: 10, color: AppColors.textSecondary),
            ),
          ],
        ),
        onLongPress: () => _confirmDelete(index),
      ),
    );
  }

  void _confirmDelete(int index) {
    Get.dialog(
      AlertDialog(
        title: Text('confirm'.tr),
        content: const Text('Remove this food entry?'),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: Text('cancel'.tr),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              controller.removeFoodEntry(index);
            },
            child: Text('confirm'.tr, style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
