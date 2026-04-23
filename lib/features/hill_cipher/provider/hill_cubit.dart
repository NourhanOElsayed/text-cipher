import 'package:flutter_bloc/flutter_bloc.dart';

part 'hill_state.dart';

class HillCubit extends Cubit<HillState> {
  HillCubit() : super(const HillState());

  void onInputTextChanged(String text) {
    if (state.isAnimating) return;
    emit(state.copyWith(
      inputText: text,
      outputText: '',
      clearIndices: true,
      currentEquation: '',
    ));
  }

  void onMatrixSizeChanged(int size) {
    if (state.isAnimating) return;
    emit(state.copyWith(
      matrixSize: size,
      keyMatrix: List.filled(size * size, '0'),
      outputText: '',
      clearIndices: true,
      currentEquation: '',
    ));
  }

  void onKeyMatrixChanged(int index, String value) {
    if (state.isAnimating) return;
    final newMatrix = List<String>.from(state.keyMatrix);
    newMatrix[index] = value;
    emit(state.copyWith(
      keyMatrix: newMatrix,
      outputText: '',
      clearIndices: true,
      currentEquation: '',
    ));
  }

  void reset() {
    emit(const HillState());
  }

  int _parseCell(String val) {
    if (val.isEmpty) return 0;
    if (int.tryParse(val) != null) {
      int parsed = int.parse(val) % 26;
      return parsed < 0 ? parsed + 26 : parsed;
    }
    String upper = val.toUpperCase().replaceAll(RegExp(r'[^A-Z]'), '');
    if (upper.isEmpty) return 0;
    return upper.codeUnitAt(0) - 65;
  }

  int _modInverse(int a, int m) {
    a = a % m;
    for (int x = 1; x < m; x++) {
      if ((a * x) % m == 1) return x;
    }
    return -1;
  }

  int _determinant(List<List<int>> matrix) {
    int n = matrix.length;
    if (n == 1) return matrix[0][0];
    if (n == 2) return matrix[0][0] * matrix[1][1] - matrix[0][1] * matrix[1][0];
    int det = 0;
    for (int p = 0; p < n; p++) {
      List<List<int>> subMatrix = [];
      for (int i = 1; i < n; i++) {
        List<int> row = [];
        for (int j = 0; j < n; j++) {
          if (j != p) row.add(matrix[i][j]);
        }
        subMatrix.add(row);
      }
      det += (p % 2 == 0 ? 1 : -1) * matrix[0][p] * _determinant(subMatrix);
    }
    return det;
  }

  List<List<int>> _invertMatrix(List<List<int>> matrix) {
    int n = matrix.length;
    int det = _determinant(matrix) % 26;
    if (det < 0) det += 26;
    int detInv = _modInverse(det, 26);
    if (detInv == -1) return [];
    List<List<int>> adj = List.generate(n, (i) => List.filled(n, 0));
    if (n == 1) return [[(detInv * matrix[0][0]) % 26]];
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        List<List<int>> sub = [];
        for (int r = 0; r < n; r++) {
          if (r == i) continue;
          List<int> row = [];
          for (int c = 0; c < n; c++) {
            if (c == j) continue;
            row.add(matrix[r][c]);
          }
          sub.add(row);
        }
        int sign = ((i + j) % 2 == 0) ? 1 : -1;
        int subDet = _determinant(sub) % 26;
        int val = (sign * subDet) % 26;
        if (val < 0) val += 26;
        adj[j][i] = (val * detInv) % 26;
      }
    }
    return adj;
  }

  Future<void> processText({required bool isEncrypting}) async {
    if (state.inputText.isEmpty || state.isAnimating) return;
    emit(state.copyWith(
      isAnimating: true,
      outputText: '',
      currentEquation: 'Validating Matrix...',
    ));

    int n = state.matrixSize;
    List<List<int>> kMatrix = List.generate(n, (i) => List.filled(n, 0));
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        kMatrix[i][j] = _parseCell(state.keyMatrix[i * n + j]);
      }
    }

    if (!isEncrypting) {
      kMatrix = _invertMatrix(kMatrix);
      if (kMatrix.isEmpty) {
        emit(state.copyWith(
          isAnimating: false,
          currentEquation: 'Matrix is not invertible mod 26. Cannot decrypt.',
        ));
        return;
      }
    } else {
      int det = _determinant(kMatrix) % 26;
      if (det < 0) det += 26;
      if (_modInverse(det, 26) == -1) {
        emit(state.copyWith(
          isAnimating: false,
          currentEquation: 'Warning: Matrix determinant is not coprime to 26.\nDecryption will be impossible.',
        ));
        await Future.delayed(const Duration(seconds: 2));
      }
    }

    String cleanInput = state.inputText.toUpperCase().replaceAll(RegExp(r'[^A-Z]'), '');
    while (cleanInput.length % n != 0) {
      cleanInput += 'X';
    }

    String resultBuilder = '';
    
    for (int i = 0; i < cleanInput.length; i += n) {
      List<int> pVector = [];
      List<int> activeIndices = [];
      for (int j = 0; j < n; j++) {
        pVector.add(cleanInput.codeUnitAt(i + j) - 65);
        activeIndices.add(i + j);
      }

      for (int r = 0; r < n; r++) {
        emit(state.copyWith(
          activeInputIndices: activeIndices,
          activeMatrixRow: r,
          currentEquation: 'Calculating Row ${r + 1}...',
        ));
        await Future.delayed(const Duration(milliseconds: 600));

        int sum = 0;
        List<String> eqParts = [];
        for (int c = 0; c < n; c++) {
          int product = kMatrix[r][c] * pVector[c];
          sum += product;
          eqParts.add('(${kMatrix[r][c]} × ${pVector[c]})');
        }
        
        int finalVal = sum % 26;
        if (finalVal < 0) finalVal += 26;
        String targetChar = String.fromCharCode(finalVal + 65);

        String fullEq = '${eqParts.join(' + ')} = $sum\n$sum mod 26 = $finalVal → $targetChar';
        
        emit(state.copyWith(currentEquation: fullEq));
        await Future.delayed(const Duration(milliseconds: 1200));

        resultBuilder += targetChar;
      }
      
      emit(state.copyWith(
        outputText: resultBuilder,
        activeMatrixRow: null,
      ));
      await Future.delayed(const Duration(milliseconds: 400));
    }

    emit(state.copyWith(
      isAnimating: false,
      clearIndices: true,
      currentEquation: isEncrypting ? 'Encryption Complete' : 'Decryption Complete',
    ));
  }
}