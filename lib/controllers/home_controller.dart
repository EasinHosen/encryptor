import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  RxString caeserEncryptedText = ''.obs;
  RxString caeserDecryptedText = ''.obs;

  RxString monoAlphabeticSubstitutionEncryptedText = ''.obs;
  RxString monoAlphabeticSubstitutionDecryptedText = ''.obs;

  RxString playfairCypherEncryptedText = ''.obs;
  RxString playfairCypherDecryptedText = ''.obs;

  RxString hillCipherEncryptedText = ''.obs;
  RxString hillCipherDecryptedText = ''.obs;

  RxString polyAlphabeticCipherEncryptedText = ''.obs;
  RxString polyAlphabeticCipherDecryptedText = ''.obs;

  RxString oneTimePadCipherEncryptedText = ''.obs;
  RxString oneTimePadCipherDecryptedText = ''.obs;

  //***Caesar cipher start***//
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
  //***Caesar cipher end***//

  //***Monoalphabetic cipher start***//
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
  //***Monoalphabetic cipher end***//

  //***playfair cipher start***//
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
  //***playfair cipher end***//

  //***Hill cipher start***//
  bool isHillKeyInvertible(String key) {
    // Convert key to matrix (2x2 or 3x3)
    final size = (key.length == 4) ? 2 : 3;
    final matrix = List.generate(size,
        (i) => List.generate(size, (j) => key.codeUnitAt(i * size + j) % 65));

    // Calculate determinant
    int det;
    if (size == 2) {
      det = matrix[0][0] * matrix[1][1] - matrix[0][1] * matrix[1][0];
    } else {
      det = matrix[0][0] *
              (matrix[1][1] * matrix[2][2] - matrix[1][2] * matrix[2][1]) -
          matrix[0][1] *
              (matrix[1][0] * matrix[2][2] - matrix[1][2] * matrix[2][0]) +
          matrix[0][2] *
              (matrix[1][0] * matrix[2][1] - matrix[1][1] * matrix[2][0]);
    }
    det = det % 26;
    if (det < 0) det += 26;

    // Check if determinant and 26 are coprime
    int gcd(int a, int b) => b == 0 ? a : gcd(b, a % b);
    return gcd(det, 26) == 1;
  }

  List<List<int>> _keyToMatrix(String key) {
    key = key.toUpperCase().replaceAll(RegExp(r'[^A-Z]'), '');
    int size = (key.length == 4) ? 2 : 3;
    if (key.length != size * size) throw Exception('Key length must be 4 or 9');
    List<List<int>> matrix = [];
    for (int i = 0; i < size; i++) {
      matrix.add(List.generate(size, (j) => key.codeUnitAt(i * size + j) - 65));
    }
    return matrix;
  }

  List<int> _modMultiply(List<List<int>> matrix, List<int> vector) {
    int size = vector.length;
    return List.generate(size, (i) {
      int sum = 0;
      for (int j = 0; j < size; j++) {
        sum += matrix[i][j] * vector[j];
      }
      return sum % 26;
    });
  }

  int _modInverse(int a, int m) {
    for (int x = 1; x < m; x++) {
      if ((a * x) % m == 1) return x;
    }
    throw Exception('No modular inverse');
  }

  List<List<int>> _matrixInverse(List<List<int>> matrix) {
    int size = matrix.length;
    int det;
    if (size == 2) {
      det = (matrix[0][0] * matrix[1][1] - matrix[0][1] * matrix[1][0]) % 26;
      int invDet = _modInverse((det + 26) % 26, 26);
      return [
        [(matrix[1][1] * invDet) % 26, ((-matrix[0][1] + 26) * invDet) % 26],
        [((-matrix[1][0] + 26) * invDet) % 26, (matrix[0][0] * invDet) % 26]
      ];
    } else if (size == 3) {
      // Calculate determinant and adjugate for 3x3
      int a = matrix[0][0], b = matrix[0][1], c = matrix[0][2];
      int d = matrix[1][0], e = matrix[1][1], f = matrix[1][2];
      int g = matrix[2][0], h = matrix[2][1], i = matrix[2][2];
      det = (a * (e * i - f * h) - b * (d * i - f * g) + c * (d * h - e * g)) %
          26;
      int invDet = _modInverse((det + 26) % 26, 26);
      List<List<int>> adj = [
        [
          ((e * i - f * h) * invDet) % 26,
          ((-(b * i - c * h) + 26) * invDet) % 26,
          ((b * f - c * e) * invDet) % 26
        ],
        [
          ((-(d * i - f * g) + 26) * invDet) % 26,
          ((a * i - c * g) * invDet) % 26,
          ((-(a * f - c * d) + 26) * invDet) % 26
        ],
        [
          ((d * h - e * g) * invDet) % 26,
          ((-(a * h - b * g) + 26) * invDet) % 26,
          ((a * e - b * d) * invDet) % 26
        ]
      ];
      // Transpose adjugate
      return List.generate(
          3, (i) => List.generate(3, (j) => (adj[j][i] + 26) % 26));
    } else {
      throw Exception('Only 2x2 and 3x3 supported');
    }
  }

  String encryptHill(String input, String key) {
    input = input.toUpperCase().replaceAll(RegExp(r'[^A-Z]'), '');
    final matrix = _keyToMatrix(key);
    int size = matrix.length;
    while (input.length % size != 0) input += 'X';
    final out = <String>[];
    for (int i = 0; i < input.length; i += size) {
      final block = input
          .substring(i, i + size)
          .split('')
          .map((c) => c.codeUnitAt(0) - 65)
          .toList();
      final enc = _modMultiply(matrix, block);
      out.addAll(enc.map((n) => String.fromCharCode(n + 65)));
    }
    return out.join();
  }

  String decryptHill(String input, String key) {
    input = input.toUpperCase().replaceAll(RegExp(r'[^A-Z]'), '');
    final matrix = _keyToMatrix(key);
    final invMatrix = _matrixInverse(matrix);
    int size = matrix.length;
    final out = <String>[];
    for (int i = 0; i < input.length; i += size) {
      final block = input
          .substring(i, i + size)
          .split('')
          .map((c) => c.codeUnitAt(0) - 65)
          .toList();
      final dec = _modMultiply(invMatrix, block);
      out.addAll(dec.map((n) => String.fromCharCode(n + 65)));
    }
    return out.join();
  }
  //***Hill cipher end***//

  //***polyalphabetic cipher starts***//
  String encryptVigenere(String text, String key) {
    text = text.toUpperCase().replaceAll(' ', '');
    key = key.toUpperCase();
    String result = '';
    for (int i = 0; i < text.length; i++) {
      int t = text.codeUnitAt(i) - 65;
      int k = key.codeUnitAt(i % key.length) - 65;
      result += String.fromCharCode(((t + k) % 26) + 65);
    }
    return result;
  }

  String decryptVigenere(String text, String key) {
    text = text.toUpperCase().replaceAll(' ', '');
    key = key.toUpperCase();
    String result = '';
    for (int i = 0; i < text.length; i++) {
      int t = text.codeUnitAt(i) - 65;
      int k = key.codeUnitAt(i % key.length) - 65;
      result += String.fromCharCode(((t - k + 26) % 26) + 65);
    }
    return result;
  }

//***polyalphabetic cipher starts***//
//***one time pad cipher starts***//
// Encrypts using one-time pad (key must match input length)
  String encryptOneTimePad(String text, String key) {
    text = text.toUpperCase().replaceAll(' ', '');
    key = key.toUpperCase().replaceAll(' ', '');

    String result = '';
    for (int i = 0; i < text.length; i++) {
      int t = text.codeUnitAt(i) - 65;
      int k = key.codeUnitAt(i) - 65;
      result += String.fromCharCode(((t + k) % 26) + 65);
    }
    return result;
  }

  String decryptOneTimePad(String text, String key) {
    text = text.toUpperCase().replaceAll(' ', '');
    key = key.toUpperCase().replaceAll(' ', '');
    if (text.length != key.length)
      throw Exception('Key length must match input length');
    String result = '';
    for (int i = 0; i < text.length; i++) {
      int t = text.codeUnitAt(i) - 65;
      int k = key.codeUnitAt(i) - 65;
      result += String.fromCharCode(((t - k + 26) % 26) + 65);
    }
    return result;
  }
//***one time pad cipher starts***//
}
