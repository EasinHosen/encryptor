import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  RxString caeserEncryptedText = ''.obs;
  RxString caeserDecryptedText = ''.obs;

  RxString monoAlphabeticSubstitutionEncryptedText = ''.obs;
  RxString monoAlphabeticSubstitutionDecryptedText = ''.obs;

  RxString playfairCypherEncryptedText = ''.obs;
  RxString playfairCypherDecryptedText = ''.obs;

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

  String encryptMonoalphabetic(String input, String key) {
    final upperKey = key.toUpperCase();
    final lowerKey = key.toLowerCase();
    return input.split('').map((char) {
      if (char.contains(RegExp(r'[A-Z]'))) {
        return upperKey[char.codeUnitAt(0) - 65];
      } else if (char.contains(RegExp(r'[a-z]'))) {
        return lowerKey[char.codeUnitAt(0) - 97];
      }
      return char;
    }).join();
  }

  String decryptMonoalphabetic(String input, String key) {
    final upperKey = key.toUpperCase();
    final lowerKey = key.toLowerCase();
    return input.split('').map((char) {
      if (char.contains(RegExp(r'[A-Z]'))) {
        final idx = upperKey.indexOf(char);
        return idx != -1 ? String.fromCharCode(65 + idx) : char;
      } else if (char.contains(RegExp(r'[a-z]'))) {
        final idx = lowerKey.indexOf(char);
        return idx != -1 ? String.fromCharCode(97 + idx) : char;
      }
      return char;
    }).join();
  }

  List<List<String>> generatePlayfairMatrix(String key) {
    key = key.toUpperCase().replaceAll('J', 'I');
    final seen = <String>{};
    final matrix = <String>[];
    for (var c in key.split('')) {
      if (RegExp(r'[A-Z]').hasMatch(c) && !seen.contains(c)) {
        seen.add(c);
        matrix.add(c);
      }
    }
    for (var c in 'ABCDEFGHIKLMNOPQRSTUVWXYZ'.split('')) {
      if (!seen.contains(c)) matrix.add(c);
    }
    return List.generate(5, (i) => matrix.sublist(i * 5, i * 5 + 5));
  }

  String _prepareText(String text) {
    text = text
        .toUpperCase()
        .replaceAll('J', 'I')
        .replaceAll(RegExp(r'[^A-Z]'), '');
    final result = <String>[];
    int i = 0;
    while (i < text.length) {
      var a = text[i];
      var b = (i + 1 < text.length) ? text[i + 1] : 'X';
      if (a == b) {
        result.add(a);
        result.add('X');
        i++;
      } else {
        result.add(a);
        result.add(b);
        i += 2;
      }
    }
    if (result.length % 2 != 0) result.add('X');
    return result.join();
  }

  String encryptPlayfair(String input, String key) {
    final matrix = generatePlayfairMatrix(key);
    final text = _prepareText(input);
    final pos = <String, List<int>>{};
    for (var i = 0; i < 5; i++) {
      for (var j = 0; j < 5; j++) {
        pos[matrix[i][j]] = [i, j];
      }
    }
    final out = <String>[];
    for (var i = 0; i < text.length; i += 2) {
      var a = text[i], b = text[i + 1];
      var pa = pos[a]!, pb = pos[b]!;
      if (pa[0] == pb[0]) {
        out.add(matrix[pa[0]][(pa[1] + 1) % 5]);
        out.add(matrix[pb[0]][(pb[1] + 1) % 5]);
      } else if (pa[1] == pb[1]) {
        out.add(matrix[(pa[0] + 1) % 5][pa[1]]);
        out.add(matrix[(pb[0] + 1) % 5][pb[1]]);
      } else {
        out.add(matrix[pa[0]][pb[1]]);
        out.add(matrix[pb[0]][pa[1]]);
      }
    }
    return out.join();
  }

  String decryptPlayfair(String input, String key) {
    final matrix = generatePlayfairMatrix(key);
    final pos = <String, List<int>>{};
    for (var i = 0; i < 5; i++) {
      for (var j = 0; j < 5; j++) {
        pos[matrix[i][j]] = [i, j];
      }
    }
    final out = <String>[];
    for (var i = 0; i < input.length; i += 2) {
      var a = input[i], b = input[i + 1];
      var pa = pos[a]!, pb = pos[b]!;
      if (pa[0] == pb[0]) {
        out.add(matrix[pa[0]][(pa[1] + 4) % 5]);
        out.add(matrix[pb[0]][(pb[1] + 4) % 5]);
      } else if (pa[1] == pb[1]) {
        out.add(matrix[(pa[0] + 4) % 5][pa[1]]);
        out.add(matrix[(pb[0] + 4) % 5][pb[1]]);
      } else {
        out.add(matrix[pa[0]][pb[1]]);
        out.add(matrix[pb[0]][pa[1]]);
      }
    }
    return out.join();
  }
}
