import 'package:flutter_bloc/flutter_bloc.dart';

part 'vigenere_state.dart';

class VigenereCubit extends Cubit<VigenereState> {
  VigenereCubit() : super(const VigenereState());

  void onInputTextChanged(String text) {
    if (state.isAnimating) return; // Prevent changes during animation
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
        keyword: newKey,
        outputText: '',
        clearIndices: true,
        currentEquation: '',
      ),
    );
  }

  Future<void> processText({required bool isEncrypting}) async {
    if (state.inputText.isEmpty || state.keyword.isEmpty || state.isAnimating) {
      return;
    }

    emit(
      state.copyWith(
        isAnimating: true,
        outputText: '',
        currentEquation: isEncrypting ? 'Encrypting...' : 'Decrypting...',
      ),
    );

    String resultBuilder = '';
    final input = state.inputText.toUpperCase();
    final key = state.keyword.toUpperCase();

    int keyTracker = 0;

    for (int i = 0; i < input.length; i++) {
      String char = input[i];

      if (RegExp(r'[A-Z]').hasMatch(char)) {
        // 1. Get the Plaintext Value (e.g., 'H' = 7)
        int startValue = char.codeUnitAt(0) - 65;

        // 2. Get the corresponding Key Value
        int currentKeyIndex = keyTracker % key.length;
        String keyChar = key[currentKeyIndex];
        int keyValue = keyChar.codeUnitAt(0) - 65;

        // 3. The Math
        int endValue;
        String mathOperator;

        if (isEncrypting) {
          endValue = (startValue + keyValue) % 26;
          mathOperator = '+';
        } else {
          endValue = (startValue - keyValue + 26) % 26;
          mathOperator = '-';
        }

        String targetChar = String.fromCharCode(endValue + 65);

        // 4. Format the equation string for display
        String equation =
            'key → $keyChar = $keyValue,    $char = ($startValue $mathOperator $keyValue) mod 26 = $endValue → $targetChar';

        // STEP 1: Highlight Input Letter, Key Letter, and Start Grid Box
        emit(
          state.copyWith(
            activeInputIndex: i,
            activeKeyIndex: currentKeyIndex,
            activeGridIndex: startValue,
            isTracing: false,
            currentEquation: equation,
          ),
        );

        await Future.delayed(const Duration(milliseconds: 1000));

        // STEP 2: The Tracing Animation (Blinking Gray)
        for (int step = 1; step <= keyValue; step++) {
          int currentStepIndex = isEncrypting
              ? (startValue + step) % 26
              : (startValue - step % 26 + 26) % 26;

          emit(
            state.copyWith(activeGridIndex: currentStepIndex, isTracing: true),
          );
          await Future.delayed(const Duration(milliseconds: 150));
        }

        // STEP 3: Lock on the final target
        resultBuilder += targetChar;
        emit(
          state.copyWith(
            outputText: resultBuilder,
            activeGridIndex: endValue,
            isTracing: false,
          ),
        );

        keyTracker++;
        await Future.delayed(const Duration(milliseconds: 600));
      } else {
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
