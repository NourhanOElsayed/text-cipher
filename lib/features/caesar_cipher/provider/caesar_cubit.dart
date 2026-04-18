import 'package:bloc/bloc.dart';

part 'caesar_state.dart';

class CaesarCubit extends Cubit<CaesarState> {
  CaesarCubit() : super(const CaesarState());

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

  void onKeyChanged(int newKey) {
    if (state.isAnimating) return;
    emit(state.copyWith(shiftKey: newKey));
  }

  Future<void> processText({required bool isEncrypting}) async {
    if (state.inputText.isEmpty || state.isAnimating) return;

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
        int startValue = char.codeUnitAt(0) - 65;
        int endValue;
        String equation;

        // THE MATH SPLIT
        if (isEncrypting) {
          endValue = (startValue + state.shiftKey) % 26;
          equation =
              '$char = ($startValue + ${state.shiftKey}) mod 26 = $endValue → ${String.fromCharCode(endValue + 65)}';
        } else {
          // Decryption Math: Add 26 to safely handle negative numbers in Dart
          endValue = (startValue - (state.shiftKey % 26) + 26) % 26;
          equation =
              '$char = ($startValue - ${state.shiftKey}) mod 26 = $endValue → ${String.fromCharCode(endValue + 65)}';
        }

        String targetChar = String.fromCharCode(endValue + 65);

        // STEP 1: Highlight Start Letter
        emit(
          state.copyWith(
            activeInputIndex: i,
            activeGridIndex: startValue,
            isTracing: false,
            currentEquation: equation,
          ),
        );

        await Future.delayed(const Duration(milliseconds: 800));

        // STEP 2: The Tracing Animation (Forwards or Backwards)
        for (int step = 1; step <= state.shiftKey; step++) {
          int currentStepIndex = isEncrypting
              ? (startValue + step) % 26
              : (startValue - step % 26 + 26) % 26; // Moves backwards

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
