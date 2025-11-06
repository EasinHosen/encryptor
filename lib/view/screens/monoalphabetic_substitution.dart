import 'package:encryptor/controllers/home_controller.dart';
import 'package:encryptor/view/common_widgets/custom_text_field.dart';
import 'package:encryptor/view/common_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MonoAlphabeticSubstitution extends StatefulWidget {
  const MonoAlphabeticSubstitution({super.key});
  static const String routeName = '/mono_alpha';

  @override
  State<MonoAlphabeticSubstitution> createState() =>
      _MonoAlphabeticSubstitutionState();
}

class _MonoAlphabeticSubstitutionState
    extends State<MonoAlphabeticSubstitution> {
  final TextEditingController inputTextController = TextEditingController();
  final TextEditingController inputShiftController =
      TextEditingController(text: 'QWERTYUIOPASDFGHJKLZXCVBNM');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MonoAlphabetic Substitution'),
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
            hintText: 'Enter shift value of 26 letter',
            keyboardType: TextInputType.text,
          ),
          PrimaryButton(
              onPressed: () {
                final input = inputTextController.text.trim();
                final key = inputShiftController.text.trim();

                if (key.length < 26) {
                  Get.showSnackbar(const GetSnackBar(
                    title: 'Error',
                    message: 'Key must be of 26 letters',
                  ));
                  return;
                }
                if (!RegExp(r'^[A-Za-z]+$').hasMatch(input)) {
                  Get.showSnackbar(const GetSnackBar(
                    title: 'Error',
                    message: 'Input must contain only letters',
                  ));
                  return;
                }

                HomeController.to.monoAlphabeticSubstitutionEncryptedText(
                    HomeController.to.encryptMonoalphabetic(input, key));
                HomeController.to.monoAlphabeticSubstitutionDecryptedText(
                    HomeController.to.decryptMonoalphabetic(
                        HomeController
                            .to.monoAlphabeticSubstitutionEncryptedText.value,
                        key));
              },
              buttonText: 'Encrypt'),
          SizedBox(height: Get.height * 0.2),
          const Text(
            'Encrypted text:',
            textAlign: TextAlign.center,
          ),
          Obx(() => Text(
                '${HomeController.to.monoAlphabeticSubstitutionEncryptedText}',
                textAlign: TextAlign.center,
              )),
          SizedBox(height: Get.height * 0.01),
          const Text(
            'Decrypted text:',
            textAlign: TextAlign.center,
          ),
          Obx(() => Text(
                '${HomeController.to.monoAlphabeticSubstitutionDecryptedText}',
                textAlign: TextAlign.center,
              )),
        ],
      ),
    );
  }
}
