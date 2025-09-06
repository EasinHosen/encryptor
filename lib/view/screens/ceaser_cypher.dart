import 'package:encryptor/controllers/home_controller.dart';
import 'package:encryptor/view/common_widgets/custom_text_field.dart';
import 'package:encryptor/view/common_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CeaserCypher extends StatefulWidget {
  const CeaserCypher({super.key});
  static const String routeName = '/ceaser';

  @override
  State<CeaserCypher> createState() => _CeaserCypherState();
}

class _CeaserCypherState extends State<CeaserCypher> {
  final TextEditingController inputTextController = TextEditingController();
  final TextEditingController inputShiftController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ceaser'),
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
            title: 'Shift value',
            hintText: 'Enter shift value',
            keyboardType: TextInputType.number,
          ),
          PrimaryButton(
              onPressed: () {
                HomeController.to.ceaserEncryptedText(HomeController.to
                    .encryptCaesar(inputTextController.text.trim(),
                        int.tryParse(inputShiftController.text.trim()) ?? 3));

                HomeController.to.ceaserDecryptedText(HomeController.to
                    .decryptCaesar(HomeController.to.ceaserEncryptedText.value,
                        int.tryParse(inputShiftController.text.trim()) ?? 3));
              },
              buttonText: 'Encrypt'),
          SizedBox(height: Get.height * 0.2),
          const Text(
            'Encrypted text:',
            textAlign: TextAlign.center,
          ),
          Obx(() => Text(
                '${HomeController.to.ceaserEncryptedText}',
                textAlign: TextAlign.center,
              )),
          SizedBox(height: Get.height * 0.01),
          const Text(
            'Decrypted text:',
            textAlign: TextAlign.center,
          ),
          Obx(() => Text(
                '${HomeController.to.ceaserDecryptedText}',
                textAlign: TextAlign.center,
              )),
        ],
      ),
    );
  }
}
