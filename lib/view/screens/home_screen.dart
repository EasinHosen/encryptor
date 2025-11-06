import 'package:encryptor/view/screens/ceaser_cypher.dart';
import 'package:encryptor/view/screens/monoalphabetic_substitution.dart';
import 'package:encryptor/view/screens/playfair_cipher.dart';
import 'package:encryptor/view/styles/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common_widgets/encryption_method_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kIsWeb
          ? null
          : AppBar(
              title: const Text(
                'Encryptor',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: AppColors.colorPrimary,
            ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        children: [
          EncryptionMethodTile(
            title: 'Caesar Cipher',
            description: 'A classic shift cipher technique.',
            onTap: () => Get.toNamed(CeaserCypher.routeName),
          ),
          EncryptionMethodTile(
            title: 'Monoalphabetic substitution',
            description:
                'Monoalphabetic substitution is a cipher technique where each letter in the plaintext is replaced by a unique corresponding letter from a fixed substitution alphabet, making the mapping consistent throughout the message.',
            onTap: () => Get.toNamed(MonoAlphabeticSubstitution.routeName),
          ),
          EncryptionMethodTile(
            title: 'Playfair Cipher',
            description:
                'The Playfair cipher is a manual symmetric encryption technique that encrypts pairs of letters using a 5x5 matrix generated from a keyword, making it more secure than simple substitution ciphers.',
            onTap: () => Get.toNamed(PlayFairCipher.routeName),
          ),
        ],
      ),
    );
  }
}
