import 'package:get/get.dart';
import 'en.dart';
import 'th.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': En.strings,
        'th_TH': Th.strings,
      };
}
