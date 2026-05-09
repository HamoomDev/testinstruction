import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/theme/app_theme.dart';
import '../controllers/food_log_controller.dart';

class AddFoodPage extends GetView<FoodLogController> {
  const AddFoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('food_log_title'.tr),
      ),
      body: Obx(() {
        switch (controller.state.value) {
          case FoodLogState.idle:
            return _idleView();
          case FoodLogState.picking:
            return _loadingView('loading'.tr);
          case FoodLogState.analyzing:
            return _loadingView('food_log_analyzing'.tr);
          case FoodLogState.result:
            return _resultView();
          case FoodLogState.error:
            return _errorView();
        }
      }),
    );
  }

  Widget _idleView() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (controller.isMockMode) _mockModeBanner(),
          const Spacer(),
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.camera_alt_outlined,
              size: 56,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'food_log_choose'.tr,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 32),
          _pickButton(
            icon: Icons.camera_alt,
            label: 'food_log_camera'.tr,
            source: ImageSource.camera,
            color: AppColors.primary,
          ),
          const SizedBox(height: 16),
          _pickButton(
            icon: Icons.photo_library_outlined,
            label: 'food_log_gallery'.tr,
            source: ImageSource.gallery,
            color: AppColors.primaryDark,
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _mockModeBanner() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.warning.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          const Icon(Icons.warning_amber_rounded, color: AppColors.warning, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'food_log_mock_note'.tr,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _pickButton({
    required IconData icon,
    required String label,
    required ImageSource source,
    required Color color,
  }) {
    return ElevatedButton.icon(
      onPressed: () => controller.pickImage(source),
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(backgroundColor: color),
    );
  }

  Widget _loadingView(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(color: AppColors.primary),
          const SizedBox(height: 24),
          Text(
            message,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
          ),
          if (controller.state.value == FoodLogState.analyzing) ...[
            const SizedBox(height: 8),
            const Text(
              'Claude AI 🤖',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _resultView() {
    final result = controller.analysisResult.value!;
    final isTh = Get.locale?.languageCode == 'th';
    final foodName = isTh ? result.foodNameTh : result.foodName;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          if (controller.selectedImage.value != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.file(
                controller.selectedImage.value!,
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          if (controller.isMockMode) ...[
            const SizedBox(height: 8),
            _mockModeBanner(),
          ],
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'food_log_result_title'.tr,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    foodName,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    result.servingSize,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const Divider(height: 24),
                  _mainCalorieRow(result.estimatedCalories),
                  const SizedBox(height: 16),
                  _macroRow(result),
                  const Divider(height: 24),
                  _confidenceChip(result.confidence),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: controller.saveEntry,
            icon: const Icon(Icons.check_circle_outline),
            label: Text('food_log_save_food'.tr),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: controller.retake,
            icon: const Icon(Icons.refresh),
            label: Text('food_log_retake'.tr),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 52),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _mainCalorieRow(int calories) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.local_fire_department, color: AppColors.secondary, size: 32),
        const SizedBox(width: 8),
        Text(
          '$calories',
          style: const TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          'unit_kcal'.tr,
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _macroRow(dynamic result) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _macroItem(
          result.proteinG.toStringAsFixed(1),
          'food_log_protein'.tr,
          const Color(0xFF2196F3),
        ),
        _macroItem(
          result.carbsG.toStringAsFixed(1),
          'food_log_carbs'.tr,
          const Color(0xFFFF9800),
        ),
        _macroItem(
          result.fatG.toStringAsFixed(1),
          'food_log_fat'.tr,
          const Color(0xFFE91E63),
        ),
      ],
    );
  }

  Widget _macroItem(String value, String label, Color color) {
    return Column(
      children: [
        Text(
          '${value}g',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
        ),
      ],
    );
  }

  Widget _confidenceChip(String confidence) {
    Color chipColor;
    switch (confidence.toLowerCase()) {
      case 'high':
        chipColor = Colors.green;
        break;
      case 'medium':
        chipColor = Colors.orange;
        break;
      default:
        chipColor = Colors.red;
    }
    return Row(
      children: [
        Text(
          '${'food_log_confidence'.tr}: ',
          style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: chipColor.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: chipColor.withValues(alpha: 0.3)),
          ),
          child: Text(
            confidence.toUpperCase(),
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: chipColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _errorView() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: AppColors.error, size: 64),
          const SizedBox(height: 16),
          Text(
            controller.errorMessage.value,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: controller.retake,
            icon: const Icon(Icons.refresh),
            label: Text('retry'.tr),
          ),
        ],
      ),
    );
  }
}
