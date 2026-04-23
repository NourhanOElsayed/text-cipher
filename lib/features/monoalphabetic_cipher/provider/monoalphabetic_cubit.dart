import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'monoalphabetic_state.dart';

class MonoalphabeticCubit extends Cubit<MonoalphabeticState> {
  MonoalphabeticCubit() : super(const MonoalphabeticState());

  void onInputTextChanged(String text) {
    if (state.isAnimating) return;
    emit(
      state.copyWith(
        inputText: text,
        outputText: '',
        clearIndices: true,
        currentEquation: '',
      ),
    );
  }

  void onKeyChanged(String newKey) {
    if (state.isAnimating) return;
    emit(
      state.copyWith(
        keyAlphabet: newKey.toUpperCase(),
        outputText: '',
        clearIndices: true,
        currentEquation: '',
      ),
    );
  }

  void generateRandomKey() {
    if (state.isAnimating) return;
    List<String> alphabets = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('');
    alphabets.shuffle(Random());
    emit(
      state.copyWith(
        keyAlphabet: alphabets.join(),
        outputText: '',
        clearIndices: true,
        currentEquation: '',
      ),
    );
  }

  void reset() {
    emit(const MonoalphabeticState());
  }

  Future<void> processText({required bool isEncrypting}) async {
    if (state.inputText.isEmpty ||
        state.keyAlphabet.length != 26 ||
        state.isAnimating)
      return;

    emit(
      state.copyWith(
        isAnimating: true,
        outputText: '',
        currentEquation: isEncrypting ? 'Encrypting...' : 'Decrypting...',
      ),
    );

    String resultBuilder = '';
    final input = state.inputText.toUpperCase();

    for (int i = 0; i < input.length; i++) {
      String char = input[i];

      if (RegExp(r'[A-Z]').hasMatch(char)) {
        int standardIndex;
        String targetChar;
        String equation;

        if (isEncrypting) {
          // 1. ENCRYPTION: Find index in normal alphabet (A=0, B=1)
          standardIndex = char.codeUnitAt(0) - 65;
          // 2. Pull from the randomized Key
          targetChar = state.keyAlphabet[standardIndex];
          equation =
              'Plaintext $char (Index $standardIndex) → Ciphertext $targetChar';
        } else {
          // 1. DECRYPTION: Find index in the randomized Key
          standardIndex = state.keyAlphabet.indexOf(char);
          // 2. Pull from the normal alphabet
          targetChar = String.fromCharCode(standardIndex + 65);
          equation =
              'Ciphertext $char (Index $standardIndex) → Plaintext $targetChar';
        }

        // Highlight the active input and the active grid box
        emit(
          state.copyWith(
            activeInputIndex: i,
            activeGridIndex: standardIndex,
            isTracing: false, // We just snap directly to it, no tracing needed!
            currentEquation: equation,
          ),
        );

        await Future.delayed(const Duration(milliseconds: 600));

        // Lock in the result
        resultBuilder += targetChar;
        emit(state.copyWith(outputText: resultBuilder));
      } else {
        // Handle spaces and punctuation
        resultBuilder += char;
        emit(state.copyWith(outputText: resultBuilder, activeInputIndex: i));
        await Future.delayed(const Duration(milliseconds: 150));
      }
    }

    emit(
      state.copyWith(
        isAnimating: false,
        clearIndices: true,
        currentEquation: isEncrypting
            ? 'Encryption Complete'
            : 'Decryption Complete',
      ),
    );
  }
}
