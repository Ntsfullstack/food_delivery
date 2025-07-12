import 'package:get/get.dart';
import 'language/vi_vn.dart';
import 'language/en_us.dart';

class MyTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'vi_VN': viVN,
    'en_US': enUS,
  };
}
