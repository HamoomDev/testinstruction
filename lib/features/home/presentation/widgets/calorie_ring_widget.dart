import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../../../core/theme/app_theme.dart';

class CalorieRingWidget extends StatelessWidget {
  final int consumed;
  final int goal;
  final int remaining;
  final double percent;
  final bool isOver;

  const CalorieRingWidget({
    super.key,
    required this.consumed,
    required this.goal,
    required this.remaining,
    required this.percent,
    required this.isOver,
  });

  @override
  Widget build(BuildContext context) {
    final ringColor = isOver ? AppColors.ringOver : AppColors.ringFill;

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CircularPercentIndicator(
              radius: 90,
              lineWidth: 14,
              percent: percent,
              backgroundColor: AppColors.ringBg,
              progressColor: ringColor,
              circularStrokeCap: CircularStrokeCap.round,
              animation: true,
              animationDuration: 800,
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    consumed.toString(),
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: ringColor,
                    ),
                  ),
                  Text(
                    'home_kcal'.tr,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    'home_consumed'.tr,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _statItem(
                  goal.toString(),
                  'home_goal'.tr,
                  AppColors.primary,
                  Icons.flag_outlined,
                ),
                _divider(),
                _statItem(
                  isOver ? 'home_over_limit'.tr : remaining.toString(),
                  'home_remaining'.tr,
                  isOver ? AppColors.error : AppColors.textSecondary,
                  isOver ? Icons.warning_amber_rounded : Icons.hourglass_bottom,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _statItem(String value, String label, Color color, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _divider() {
    return Container(
      width: 1,
      height: 48,
      color: const Color(0xFFE0E0E0),
    );
  }
}

