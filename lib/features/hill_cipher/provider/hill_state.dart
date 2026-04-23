part of 'hill_cubit.dart';

class HillState {
  final String inputText;
  final String keyword;
  final String outputText;
  
  // Hill specific data
  final List<List<int>> keyMatrix; 
  final bool isValidKey;
  final List<String> formattedPairs;
  
  // Animation trackers
  final bool isAnimating;
  final int? activePairIndex; 
  final int? activeMatrixRow; // Tracks which row of the key matrix is multiplying
  final List<int> currentVector; // The 2x1 plaintext/ciphertext column
  final List<int?> targetVector; // The resulting 2x1 column
  final String currentEquation; 

  const HillState({
    this.inputText = '',
    this.keyword = 'HILL', // Default to a known valid invertible key
    this.outputText = '',
    this.keyMatrix = const [[0, 0], [0, 0]],
    this.isValidKey = true,
    this.formattedPairs = const [],
    this.isAnimating = false,
    this.activePairIndex,
    this.activeMatrixRow,
    this.currentVector = const [],
    this.targetVector = const [],
    this.currentEquation = '',
  });

  HillState copyWith({
    String? inputText,
    String? keyword,
    String? outputText,
    List<List<int>>? keyMatrix,
    bool? isValidKey,
    List<String>? formattedPairs,
    bool? isAnimating,
    int? activePairIndex,
    int? activeMatrixRow,
    List<int>? currentVector,
    List<int?>? targetVector,
    String? currentEquation,
    bool clearAnimation = false,
  }) {
    return HillState(
      inputText: inputText ?? this.inputText,
      keyword: keyword ?? this.keyword,
      outputText: outputText ?? this.outputText,
      keyMatrix: keyMatrix ?? this.keyMatrix,
      isValidKey: isValidKey ?? this.isValidKey,
      formattedPairs: formattedPairs ?? this.formattedPairs,
      isAnimating: isAnimating ?? this.isAnimating,
      activePairIndex: clearAnimation ? null : (activePairIndex ?? this.activePairIndex),
      activeMatrixRow: clearAnimation ? null : (activeMatrixRow ?? this.activeMatrixRow),
      currentVector: clearAnimation ? const [] : (currentVector ?? this.currentVector),
      targetVector: clearAnimation ? const [] : (targetVector ?? this.targetVector),
      currentEquation: currentEquation ?? this.currentEquation,
    );
  }
}