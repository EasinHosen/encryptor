import 'package:encryptor/controllers/home_controller.dart';
import 'package:encryptor/view/common_widgets/custom_text_field.dart';
import 'package:encryptor/view/common_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlayFairCipher extends StatefulWidget {
  const PlayFairCipher({super.key});
  static const String routeName = '/playfair';

  @override
  State<PlayFairCipher> createState() => _PlayFairCipherState();
}

class _PlayFairCipherState extends State<PlayFairCipher> {
  final TextEditingController inputTextController = TextEditingController();
  final TextEditingController inputShiftController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Playfair Cipher'),
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
            controller: inputShiftController,
            title: 'Key value',
            hintText: 'Enter a word of phrase',
            keyboardType: TextInputType.text,
          ),
          PrimaryButton(
            onPressed: () {
              final input = inputTextController.text.trim();
              final key = inputShiftController.text.trim();

              if (key.isEmpty || !RegExp(r'^[A-Za-z]+$').hasMatch(key)) {
                Get.showSnackbar(const GetSnackBar(
                  title: 'Error',
                  message: 'Key must contain only letters',
                ));
                return;
              }
              if (!RegExp(r'^[A-Za-z\s]+$').hasMatch(input)) {
                Get.showSnackbar(const GetSnackBar(
                  title: 'Error',
                  message: 'Input must contain only letters and spaces',
                ));
                return;
              }

              // Store space positions
              final spacePositions = <int>[];
              for (int i = 0; i < input.length; i++) {
                if (input[i] == ' ') spacePositions.add(i);
              }

              final encrypted = HomeController.to.encryptPlayfair(input, key);
              HomeController.to.playfairCypherEncryptedText(encrypted);

              var decrypted = HomeController.to.decryptPlayfair(encrypted, key);

              // Re-insert spaces
              for (final pos in spacePositions) {
                if (pos < decrypted.length) {
                  decrypted = decrypted.substring(0, pos) +
                      ' ' +
                      decrypted.substring(pos);
                }
              }

              HomeController.to.playfairCypherDecryptedText(decrypted);
            },
            buttonText: 'Encrypt',
          ),
          SizedBox(height: Get.height * 0.2),
          const Text(
            'Encrypted text:',
            textAlign: TextAlign.center,
          ),
          Obx(() => Text(
                '${HomeController.to.playfairCypherEncryptedText}',
                textAlign: TextAlign.center,
              )),
          SizedBox(height: Get.height * 0.01),
          const Text(
            'Decrypted text:',
            textAlign: TextAlign.center,
          ),
          Obx(() => Text(
                '${HomeController.to.playfairCypherDecryptedText}',
                textAlign: TextAlign.center,
              )),
        ],
      ),
    );
  }
}
