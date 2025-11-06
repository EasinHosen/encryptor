import 'package:encryptor/view/screens/ceaser_cypher.dart';
import 'package:encryptor/view/screens/hill_cipher.dart';
import 'package:encryptor/view/screens/monoalphabetic_substitution.dart';
import 'package:encryptor/view/screens/onetimepad_cipher.dart';
import 'package:encryptor/view/screens/playfair_cipher.dart';
import 'package:encryptor/view/screens/polyalphabetic_cipher.dart';
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
          EncryptionMethodTile(
            title: 'Hill Cipher',
            description:
                'The Hill cipher is a polygraphic substitution cipher that uses linear algebra to encrypt blocks of letters. It applies a key matrix to plaintext blocks, making it more secure than simple substitution ciphers. Decryption requires the inverse of the key matrix.',
            onTap: () => Get.toNamed(HillCipher.routeName),
          ),
          EncryptionMethodTile(
            title: 'Polyalphabetic Cipher',
            description:
                'A polyalphabetic cipher encrypts text by using multiple substitution alphabets, typically controlled by a keyword. Each letter in the plaintext is shifted by a different amount depending on the corresponding letter in the key, making the cipher more resistant to frequency analysis than simple substitution ciphers. The Vigenère cipher is a well-known example.',
            onTap: () => Get.toNamed(PolyalphabeticCipher.routeName),
          ),
          EncryptionMethodTile(
            title: 'One-time pad Cipher',
            description:
                'The one-time pad cipher encrypts text using a random key that is as long as the plaintext. Each letter is shifted according to the corresponding key letter, and the key is used only once. This method provides perfect secrecy when the key is truly random and kept secret.',
            onTap: () => Get.toNamed(OneTimePadCipher.routeName),
          ),
        ],
      ),
    );
  }
}
