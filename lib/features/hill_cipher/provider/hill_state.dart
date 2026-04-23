part of 'hill_cubit.dart';

class HillState {
  final String inputText;
  final String outputText;
  final int matrixSize;
  final List<String> keyMatrix;
  final bool isAnimating;
  final List<int> activeInputIndices;
  final int? activeMatrixRow;
  final String currentEquation;

  const HillState({
    this.inputText = '',
    this.outputText = '',
    this.matrixSize = 2,
    this.keyMatrix = const ['0', '0', '0', '0'],
    this.isAnimating = false,
    this.activeInputIndices = const [],
    this.activeMatrixRow,
    this.currentEquation = '',
  });

  HillState copyWith({
    String? inputText,
    String? outputText,
    int? matrixSize,
    List<String>? keyMatrix,
    bool? isAnimating,
    List<int>? activeInputIndices,
    int? activeMatrixRow,
    String? currentEquation,
    bool clearIndices = false,
  }) {
    return HillState(
      inputText: inputText ?? this.inputText,
      outputText: outputText ?? this.outputText,
      matrixSize: matrixSize ?? this.matrixSize,
      keyMatrix: keyMatrix ?? this.keyMatrix,
      isAnimating: isAnimating ?? this.isAnimating,
      activeInputIndices: clearIndices ? const [] : (activeInputIndices ?? this.activeInputIndices),
      activeMatrixRow: clearIndices ? null : (activeMatrixRow ?? this.activeMatrixRow),
      currentEquation: currentEquation ?? this.currentEquation,
    );
  }
}