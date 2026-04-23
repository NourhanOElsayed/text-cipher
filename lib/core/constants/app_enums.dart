enum EncryptionMode { encryption, decryption }

extension EncryptionModeExtension on EncryptionMode {
  String get modeTitle {
    switch (this) {
      case EncryptionMode.encryption:
        return 'Encryption';
      case EncryptionMode.decryption:
        return 'Decryption';
    }
  }
}

enum CipherType { caesar, vigenere, playfair ,
monoalphabetic }

extension CipherTypeExtension on CipherType {
  String get cipherTitle {
    switch (this) {
      case CipherType.caesar:
        return 'Caesar Cipher';
      case CipherType.vigenere:
        return 'Vigenère Cipher';
      case CipherType.playfair:
        return 'Playfair Cipher';
      case CipherType.monoalphabetic:
        return 'Monoalphabetic Cipher';
    }
  }
}
