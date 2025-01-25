import 'package:encrypt/encrypt.dart';
import 'dart:convert';

// followed best practices from https://pub.dev/packages/encrypt
// Arjun doesn't know if this is the best way to do it, but it's a start
class SSNEncryption {
  // Store key securely, preferably in environment variables
  static const String _keyString =
      'VqjfSZFEYPRFwj44jnVCHz0AUNrwiraaxN+2bGTJ3Jg=';
  static final Key _key = Key(base64.decode(_keyString));
  static final IV _iv = IV.fromLength(16);

  // Create a single encrypter instance with CBC mode
  static final Encrypter _encrypter = Encrypter(
    AES(
      _key,
      mode: AESMode.cbc,
      padding: 'PKCS7',
    ),
  );

  static String encryptSSN(String ssn) {
    try {
      // Normalize input: remove any non-numeric characters
      final cleanSSN = ssn.replaceAll(RegExp(r'[^\d]'), '');

      // Add padding to ensure block size alignment
      final paddedSSN = cleanSSN.padRight(16, ' ');

      final encrypted = _encrypter.encrypt(paddedSSN, iv: _iv);
      return encrypted.base64;
    } catch (e) {
      throw Exception('Encryption failed: $e');
    }
  }

  static String decryptSSN(Encrypted encryptedSSN) {
    try {
      final decrypted = _encrypter.decrypt(encryptedSSN, iv: _iv);

      // Clean up the decrypted result: remove non-numeric chars and trim
      return decrypted.replaceAll(RegExp(r'[^\d]'), '').trim();
    } catch (e) {
      // Add more detailed error information
      print('Encrypted data: ${encryptedSSN.base64}');
      print('IV: ${_iv.base64}');
      throw Exception('Decryption failed: $e');
    }
  }

  // Add a test method to verify encryption/decryption
  static void testEncryptDecrypt() {
    const testSSN = "123456789";
    try {
      final encrypted = encryptSSN(testSSN);
      print('Test encrypted: $encrypted');

      final decrypted = decryptSSN(Encrypted.fromBase64(encrypted));
      print('Test decrypted: $decrypted');

      if (testSSN == decrypted) {
        print('Encryption test passed!');
      } else {
        print('Encryption test failed! Expected $testSSN but got $decrypted');
      }
    } catch (e) {
      print('Test failed with error: $e');
    }
  }
}
