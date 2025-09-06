import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  RxString ceaserEncryptedText = ''.obs;
  RxString ceaserDecryptedText = ''.obs;

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
}
