import 'package:encryptor/controllers/home_controller.dart';
import 'package:encryptor/view/common_widgets/custom_text_field.dart';
import 'package:encryptor/view/common_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HillCipher extends StatefulWidget {
  const HillCipher({super.key});
  static const String routeName = '/hill';

  @override
  State<HillCipher> createState() => _HillCipherState();
}

class _HillCipherState extends State<HillCipher> {
  final TextEditingController inputTextController = TextEditingController();
  final TextEditingController inputKeyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hill Cipher'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          CustomTextField(
            controller: inputTextController,
            title: 'Input',
            hintText: 'Enter text',
            maxLines: 3,
          ),
          CustomTextField(
            controller: inputKeyController,
            title: 'Key value',
            hintText: 'Enter a single word',
            keyboardType: TextInputType.text,
          ),
          PrimaryButton(
            onPressed: () {
              final input = inputTextController.text.trim();
              final key = inputKeyController.text.trim();

              if (key.isEmpty ||
                  !(RegExp(r'^[A-Za-z]+$').hasMatch(key) &&
                      (key.length == 4 || key.length == 9))) {
                Get.showSnackbar(const GetSnackBar(
                  title: 'Error',
                  duration: Duration(seconds: 3),
                  message:
                      'Key must contain only letters and be 4 or 9 characters (for 2x2 or 3x3 matrix)',
                ));
                return;
              }
              if (!HomeController.to.isHillKeyInvertible(key)) {
                Get.showSnackbar(const GetSnackBar(
                  title: 'Error',
                  duration: Duration(seconds: 3),
                  message:
                      'Key is not invertible. Please choose a different key.',
                ));
                return;
              }
              if (!RegExp(r'^[A-Za-z\s]+$').hasMatch(input)) {
                Get.showSnackbar(const GetSnackBar(
                  title: 'Error',
                  duration: Duration(seconds: 3),
                  message: 'Input must contain only letters and spaces',
                ));
                return;
              }

              // Store space positions
              final spacePositions = <int>[];
              for (int i = 0; i < input.length; i++) {
                if (input[i] == ' ') spacePositions.add(i);
              }

              final encrypted = HomeController.to.encryptHill(input, key);
              HomeController.to.hillCipherEncryptedText(encrypted);

              var decrypted = HomeController.to.decryptHill(encrypted, key);

              decrypted = decrypted.replaceAll(RegExp(r'X+$'), '');
              // Re-insert spaces
              for (final pos in spacePositions) {
                if (pos < decrypted.length) {
                  decrypted =
                      '${decrypted.substring(0, pos)} ${decrypted.substring(pos)}';
                }
              }
              HomeController.to.hillCipherDecryptedText(decrypted);
            },
            buttonText: 'Encrypt',
          ),
          SizedBox(height: Get.height * 0.2),
          const Text(
            'Encrypted text:',
            textAlign: TextAlign.center,
          ),
          Obx(() => Text(
                '${HomeController.to.hillCipherEncryptedText}',
                textAlign: TextAlign.center,
              )),
          SizedBox(height: Get.height * 0.01),
          const Text(
            'Decrypted text:',
            textAlign: TextAlign.center,
          ),
          Obx(() => Text(
                '${HomeController.to.hillCipherDecryptedText}',
                textAlign: TextAlign.center,
              )),
        ],
      ),
    );
  }
}
