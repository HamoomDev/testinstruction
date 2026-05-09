import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_theme.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingPage extends GetView<OnboardingController> {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('onboarding_title'.tr),
        actions: [_langToggleButton()],
      ),
      body: Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _headerCard(),
              const SizedBox(height: 20),
              _nameField(),
              const SizedBox(height: 16),
              _genderSelector(),
              const SizedBox(height: 16),
              _ageField(),
              const SizedBox(height: 16),
              _heightField(),
              const SizedBox(height: 16),
              _weightField(),
              const SizedBox(height: 16),
              _targetWeightField(),
              const SizedBox(height: 16),
              _activitySelector(),
              const SizedBox(height: 32),
              _saveButton(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _langToggleButton() {
    return Obx(() {
      final isEn = Get.locale?.languageCode == 'en';
      return TextButton(
        onPressed: () {
          if (isEn) {
            Get.updateLocale(const Locale('th', 'TH'));
            Get.find<dynamic>(); // trigger rebuild
          } else {
            Get.updateLocale(const Locale('en', 'US'));
          }
        },
        child: Text(
          isEn ? 'TH' : 'EN',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      );
    });
  }

  Widget _headerCard() {
    return Card(
      color: AppColors.primary.withValues(alpha: 0.1),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.info_outline, color: AppColors.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'onboarding_subtitle'.tr,
                style: const TextStyle(
                  color: AppColors.primaryDark,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _nameField() {
    return TextFormField(
      controller: controller.nameController,
      validator: controller.validateRequired,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        labelText: 'field_name'.tr,
        hintText: 'field_name_hint'.tr,
        prefixIcon: const Icon(Icons.person_outline),
      ),
    );
  }

  Widget _genderSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'field_gender'.tr,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Obx(() => Row(
              children: [
                _genderOption(true, 'gender_male'.tr, Icons.male),
                const SizedBox(width: 12),
                _genderOption(false, 'gender_female'.tr, Icons.female),
              ],
            )),
      ],
    );
  }

  Widget _genderOption(bool male, String label, IconData icon) {
    return Obx(() {
      final selected = controller.isMale.value == male;
      return Expanded(
        child: GestureDetector(
          onTap: () => controller.setGender(male),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: selected ? AppColors.primary : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: selected ? AppColors.primary : const Color(0xFFE0E0E0),
                width: selected ? 2 : 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: selected ? Colors.white : AppColors.textSecondary, size: 20),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: TextStyle(
                    color: selected ? Colors.white : AppColors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _ageField() {
    return TextFormField(
      controller: controller.ageController,
      validator: controller.validateNumber,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'field_age'.tr,
        hintText: 'field_age_hint'.tr,
        prefixIcon: const Icon(Icons.cake_outlined),
      ),
    );
  }

  Widget _heightField() {
    return TextFormField(
      controller: controller.heightController,
      validator: controller.validateNumber,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'field_height'.tr,
        hintText: 'field_height_hint'.tr,
        prefixIcon: const Icon(Icons.height),
        suffixText: 'unit_cm'.tr,
      ),
    );
  }

  Widget _weightField() {
    return TextFormField(
      controller: controller.weightController,
      validator: controller.validateNumber,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'field_weight'.tr,
        hintText: 'field_weight_hint'.tr,
        prefixIcon: const Icon(Icons.monitor_weight_outlined),
        suffixText: 'unit_kg'.tr,
      ),
    );
  }

  Widget _targetWeightField() {
    return TextFormField(
      controller: controller.targetWeightController,
      validator: controller.validateNumber,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'field_target_weight'.tr,
        hintText: 'field_target_weight_hint'.tr,
        prefixIcon: const Icon(Icons.flag_outlined),
        suffixText: 'unit_kg'.tr,
      ),
    );
  }

  Widget _activitySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'field_activity'.tr,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Obx(() => Column(
              children: controller.activityOptions.map((level) {
                final selected = controller.selectedActivity.value == level;
                return GestureDetector(
                  onTap: () => controller.setActivity(level),
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: selected ? AppColors.primary.withValues(alpha: 0.1) : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: selected ? AppColors.primary : const Color(0xFFE0E0E0),
                        width: selected ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          selected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                          color: selected ? AppColors.primary : AppColors.textSecondary,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'activity_$level'.tr,
                            style: TextStyle(
                              color: selected ? AppColors.primaryDark : AppColors.textPrimary,
                              fontWeight: selected ? FontWeight.w500 : FontWeight.normal,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            )),
      ],
    );
  }

  Widget _saveButton() {
    return Obx(() => ElevatedButton(
          onPressed: controller.isLoading.value ? null : controller.saveProfile,
          child: controller.isLoading.value
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : Text('onboarding_save'.tr),
        ));
  }
}
