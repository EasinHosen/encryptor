import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
              title: const Text('Encryptor'),
            ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        children: const [
          EncryptionMethodTile(
            title: 'Caesar Cipher',
            description: 'A classic shift cipher technique.',
            routeName: '/caesar',
          ),
          // Add more EncryptionMethodTile widgets here for other methods
        ],
      ),
    );
  }
}
