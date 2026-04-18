import 'package:flutter_bloc/flutter_bloc.dart';

part 'playfair_state.dart';

class PlayfairCubit extends Cubit<PlayfairState> {
  PlayfairCubit() : super(const PlayfairState()) {
    _updateMatrixAndPairs();
  }

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
    _updateMatrixAndPairs();
  }

  void onKeyChanged(String key) {
    if (state.isAnimating) return;
    emit(
      state.copyWith(
        keyword: key,
        outputText: '',
        clearIndices: true,
        currentEquation: '',
      ),
    );
    _updateMatrixAndPairs();
  }

  void _updateMatrixAndPairs() {
    // 1. Determine whether to use 'I' or 'J' as the primary letter
    String rawKey = state.keyword.toUpperCase().replaceAll(
      RegExp(r'[^A-Z]'),
      '',
    );
    bool useJ = rawKey.contains('J');

    String primaryChar = useJ ? 'J' : 'I';
    String dropChar = useJ ? 'I' : 'J';

    // 2. Build the 5x5 Matrix
    // Replace the dropped char with the primary char in the key
    String key = rawKey.replaceAll(dropChar, primaryChar);

    // Remove the dropped char completely from our alphabet string
    String alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".replaceAll(dropChar, '');
    String matrixString = "";

    // Add unique keyword letters
    for (int i = 0; i < key.length; i++) {
      if (!matrixString.contains(key[i])) matrixString += key[i];
    }
    // Fill remaining alphabet
    for (int i = 0; i < alphabet.length; i++) {
      if (!matrixString.contains(alphabet[i])) matrixString += alphabet[i];
    }

    // 3. Format Plaintext into Digraphs (e.g., HELLO -> HE, LX, LO)
    // We MUST replace the dropped char in the plaintext too, so the math can find it in the grid!
    String cleanInput = state.inputText
        .toUpperCase()
        .replaceAll(RegExp(r'[^A-Z]'), '')
        .replaceAll(dropChar, primaryChar);

    List<String> pairs = [];

    for (int i = 0; i < cleanInput.length; i++) {
      String first = cleanInput[i];
      String second = (i + 1 < cleanInput.length)
          ? cleanInput[i + 1]
          : 'X'; // Pad with X if odd

      if (first == second) {
        // If it's a double letter (like 'LL'), split it with an 'X'
        pairs.add("${first}X");
      } else {
        pairs.add("$first$second");
        i++; // Skip the next letter since we successfully paired it
      }
    }

    emit(state.copyWith(matrix: matrixString.split(''), formattedPairs: pairs));
  }

  // --- THE ANIMATION TIMELINE ---
  Future<void> processText({required bool isEncrypting}) async {
    if (state.formattedPairs.isEmpty || state.isAnimating) return;

    emit(
      state.copyWith(isAnimating: true, outputText: '', currentEquation: ''),
    );
    String finalResult = '';

    for (int i = 0; i < state.formattedPairs.length; i++) {
      String pair = state.formattedPairs[i];
      int idx1 = state.matrix.indexOf(pair[0]);
      int idx2 = state.matrix.indexOf(pair[1]);

      // Calculate Coordinates
      int row1 = idx1 ~/ 5, col1 = idx1 % 5;
      int row2 = idx2 ~/ 5, col2 = idx2 % 5;

      int tgtRow1, tgtCol1, tgtRow2, tgtCol2;
      String ruleText = "";

      // APPLY PLAYFAIR RULES
      if (row1 == row2) {
        ruleText = "Same Row (Shift ${isEncrypting ? 'Right' : 'Left'})";
        int shift = isEncrypting ? 1 : 4; // 4 is equivalent to -1 mod 5
        tgtCol1 = (col1 + shift) % 5;
        tgtCol2 = (col2 + shift) % 5;
        tgtRow1 = row1;
        tgtRow2 = row2;
      } else if (col1 == col2) {
        ruleText = "Same Column (Shift ${isEncrypting ? 'Down' : 'Up'})";
        int shift = isEncrypting ? 1 : 4;
        tgtRow1 = (row1 + shift) % 5;
        tgtRow2 = (row2 + shift) % 5;
        tgtCol1 = col1;
        tgtCol2 = col2;
      } else {
        ruleText = "Different Row and Column (Rectangle Swap)";
        tgtRow1 = row1;
        tgtCol1 = col2; // Swap columns
        tgtRow2 = row2;
        tgtCol2 = col1;
      }

      int tgtIdx1 = tgtRow1 * 5 + tgtCol1;
      int tgtIdx2 = tgtRow2 * 5 + tgtCol2;
      String cipherPair = "${state.matrix[tgtIdx1]}${state.matrix[tgtIdx2]}";

      // STEP 1: Highlight Original Pair (Purple)
      emit(
        state.copyWith(
          activePairIndex: i,
          activeMatrixIndices: [idx1, idx2],
          targetMatrixIndices: [], // Clear green
          currentEquation: "$pair → $ruleText",
        ),
      );
      await Future.delayed(const Duration(milliseconds: 1000));

      // STEP 2: Highlight Target Pair (Green)
      emit(
        state.copyWith(
          targetMatrixIndices: [tgtIdx1, tgtIdx2],
          currentEquation: "$pair → $ruleText\n$pair → $cipherPair",
        ),
      );
      await Future.delayed(const Duration(milliseconds: 1000));

      // STEP 3: Append to Output
      finalResult += cipherPair;
      emit(state.copyWith(outputText: finalResult));
      await Future.delayed(const Duration(milliseconds: 500));
    }

    emit(
      state.copyWith(
        isAnimating: false,
        clearIndices: true,
        currentEquation: 'Processing Complete',
      ),
    );
  }
}
