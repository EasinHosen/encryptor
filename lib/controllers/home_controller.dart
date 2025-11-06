import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  RxString caeserEncryptedText = ''.obs;
  RxString caeserDecryptedText = ''.obs;

  RxString monoAlphabeticSubstitutionEncryptedText = ''.obs;
  RxString monoAlphabeticSubstitutionDecryptedText = ''.obs;

  String encryptCaesar(String input, int shift) {
    return input.split('').map((char) {
      if (char.contains(RegExp(r'[A-Za-z]'))) {
        final base = char.codeUnitAt(0) >= 97 ? 97 : 65;
        return String.fromCharCode(
          ((char.codeUnitAt(0) - base + shift) % 26) + base,
        );
      }
      return char;
    }).join();
  }

  String decryptCaesar(String input, int shift) {
    return input.split('').map((char) {
      if (char.contains(RegExp(r'[A-Za-z]'))) {
        final base = char.codeUnitAt(0) >= 97 ? 97 : 65;
        return String.fromCharCode(
          ((char.codeUnitAt(0) - base - shift + 26) % 26) + base,
        );
      }
      return char;
    }).join();
  }

  String encryptMonoalphabetic(String input, String key) {
    final upperKey = key.toUpperCase();
    final lowerKey = key.toLowerCase();
    return input.split('').map((char) {
      if (char.contains(RegExp(r'[A-Z]'))) {
        return upperKey[char.codeUnitAt(0) - 65];
      } else if (char.contains(RegExp(r'[a-z]'))) {
        return lowerKey[char.codeUnitAt(0) - 97];
      }
      return char;
    }).join();
  }

  String decryptMonoalphabetic(String input, String key) {
    final upperKey = key.toUpperCase();
    final lowerKey = key.toLowerCase();
    return input.split('').map((char) {
      if (char.contains(RegExp(r'[A-Z]'))) {
        final idx = upperKey.indexOf(char);
        return idx != -1 ? String.fromCharCode(65 + idx) : char;
      } else if (char.contains(RegExp(r'[a-z]'))) {
        final idx = lowerKey.indexOf(char);
        return idx != -1 ? String.fromCharCode(97 + idx) : char;
      }
      return char;
    }).join();
  }
}
