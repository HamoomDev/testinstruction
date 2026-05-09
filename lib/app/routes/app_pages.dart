import 'package:get/get.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/onboarding/presentation/bindings/onboarding_binding.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/home/presentation/bindings/home_binding.dart';
import '../../features/food_log/presentation/pages/add_food_page.dart';
import '../../features/food_log/presentation/bindings/food_log_binding.dart';
import 'app_routes.dart';

abstract class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingPage(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.addFood,
      page: () => const AddFoodPage(),
      binding: FoodLogBinding(),
    ),
  ];
}
