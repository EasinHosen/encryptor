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
              },
              buttonText: 'Encrypt'),
          SizedBox(height: Get.height * 0.01),
          Obx(() => Text(
              'Encrypted text: \n${HomeController.to.ceaserEncryptedText}')),
          SizedBox(height: Get.height * 0.01),
          Text('Decrypted text: \n'),
        ],
      ),
    );
  }
}
