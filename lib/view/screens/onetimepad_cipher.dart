import 'package:encryptor/controllers/home_controller.dart';
import 'package:encryptor/view/common_widgets/custom_text_field.dart';
import 'package:encryptor/view/common_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OneTimePadCipher extends StatefulWidget {
  const OneTimePadCipher({super.key});
  static const String routeName = '/polyalphabetic';

  @override
  State<OneTimePadCipher> createState() => OneTimePadCipherState();
}

class OneTimePadCipherState extends State<OneTimePadCipher> {
  final TextEditingController inputTextController = TextEditingController();
  final TextEditingController inputKeyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OneTimePad Cipher'),
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
              final key = inputKeyController.text.replaceAll(' ', '').trim();

              // Validate input: only letters and spaces
              if (!RegExp(r'^[A-Za-z\s]+$').hasMatch(input) || input.isEmpty) {
                Get.showSnackbar(const GetSnackBar(
                  title: 'Error',
                  duration: Duration(seconds: 3),
                  message: 'Input must contain only letters and spaces.',
                ));
                return;
              }

              final inputNoSpaces = input.replaceAll(' ', '');
              // Validate key: only letters, no spaces, length matches input (excluding spaces)
              if (!RegExp(r'^[A-Za-z]+$').hasMatch(key)) {
                Get.showSnackbar(const GetSnackBar(
                  title: 'Error',
                  duration: Duration(seconds: 3),
                  message: 'Key must contain only letters.',
                ));
                return;
              }
              if (key.length != inputNoSpaces.length) {
                Get.showSnackbar(const GetSnackBar(
                  title: 'Error',
                  duration: Duration(seconds: 3),
                  message: 'Key must match input length (excluding spaces).',
                ));
                return;
              }

              // Store space positions
              final spacePositions = <int>[];
              for (int i = 0; i < input.length; i++) {
                if (input[i] == ' ') spacePositions.add(i);
              }

              final encrypted = HomeController.to.encryptOneTimePad(input, key);
              HomeController.to.oneTimePadCipherEncryptedText(encrypted);

              var decrypted =
                  HomeController.to.decryptOneTimePad(encrypted, key);

              // Re-insert spaces
              for (final pos in spacePositions) {
                if (pos < decrypted.length) {
                  decrypted =
                      '${decrypted.substring(0, pos)} ${decrypted.substring(pos)}';
                }
              }
              HomeController.to.oneTimePadCipherDecryptedText(decrypted);
            },
            buttonText: 'Encrypt',
          ),
          SizedBox(height: Get.height * 0.2),
          const Text(
            'Encrypted text:',
            textAlign: TextAlign.center,
          ),
          Obx(() => Text(
                '${HomeController.to.oneTimePadCipherEncryptedText}',
                textAlign: TextAlign.center,
              )),
          SizedBox(height: Get.height * 0.01),
          const Text(
            'Decrypted text:',
            textAlign: TextAlign.center,
          ),
          Obx(() => Text(
                '${HomeController.to.oneTimePadCipherDecryptedText}',
                textAlign: TextAlign.center,
              )),
        ],
      ),
    );
  }
}
