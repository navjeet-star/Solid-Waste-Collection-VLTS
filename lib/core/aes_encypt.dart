import 'dart:convert';
import 'dart:core';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
class AESENCRYPTION {

  String aesEncryption({required String plainText,}) {
    Key keyBytes = Key.fromUtf8('e8ffc7e56311679f12b6fc91aa77a5eb');
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(keyBytes, mode: AESMode.ecb,padding: 'PKCS7'));
    final encryptValue = encrypter.encrypt(plainText, iv: iv);
    return encryptValue.base64;
  }

  String aesdecryption({required String enryptedvlue,}) {
    Key keyBytes = Key.fromUtf8('e8ffc7e56311679f12b6fc91aa77a5eb');
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(keyBytes, mode: AESMode.ecb,padding: 'PKCS7'));
    final decryptedValue = encrypter.decrypt64(enryptedvlue, iv: iv);
    //debugPrint("Decrypted Value=> $decryptedValue");
    return decryptedValue;
  }

  String  getSha256(String input) {
    // Create a SHA-256 hash
    var sha2566 = sha256.convert(utf8.encode(input));
    // Convert the hash to a BigInteger
    var bigInt = BigInt.parse(sha2566.toString(), radix: 16);
    // Convert the BigInteger to a hexadecimal string
    var hashText = bigInt.toRadixString(16);
    // Pad the hash with zeroes if it's shorter than 32 characters
    while (hashText.length < 64) {
      hashText = '0' + hashText;
    }
    return hashText;
  }

  String getSalt(int n) {
    String AlphaNumericString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvxyz";
    StringBuffer sb = StringBuffer();
    for (int i = 0; i < n; i++) {
      int index = (AlphaNumericString.length * Random().nextDouble()).floor();
      //debugPrint("index => $index");
      sb.write(AlphaNumericString[index]);
    }
    //debugPrint("sb..... "+sb.toString());
    return sb.toString();
  }
}