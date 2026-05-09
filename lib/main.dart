import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'core/i18n/app_translations.dart';
import 'core/services/storage_service.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await Get.putAsync<StorageService>(() => StorageService().init());
  runApp(const CalorieCounterApp());
}

class CalorieCounterApp extends StatelessWidget {
  const CalorieCounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = Get.find<StorageService>();
    final savedLocale = storage.getLocale();
    final localeParts = savedLocale.split('_');

    return GetMaterialApp(
      title: 'Calorie Counter AI',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      translations: AppTranslations(),
      locale: Locale(localeParts[0], localeParts[1]),
      fallbackLocale: const Locale('th', 'TH'),
      initialRoute: AppRoutes.splash,
      getPages: AppPages.routes,
    );
  }
}
