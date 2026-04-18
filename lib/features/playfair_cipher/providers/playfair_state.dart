part of 'playfair_cubit.dart';

class PlayfairState {
  final String inputText;
  final String keyword;
  final String outputText;

  final List<String> matrix;
  final List<String> formattedPairs;

  final bool isAnimating;
  final int? activePairIndex;
  final List<int> activeMatrixIndices;
  final List<int> targetMatrixIndices;
  final String currentEquation;

  const PlayfairState({
    this.inputText = '',
    this.keyword = '',
    this.outputText = '',
    this.matrix = const [],
    this.formattedPairs = const [],
    this.isAnimating = false,
    this.activePairIndex,
    this.activeMatrixIndices = const [],
    this.targetMatrixIndices = const [],
    this.currentEquation = '',
  });
  PlayfairState copyWith({
    String? inputText,
    String? keyword,
    String? outputText,
    List<String>? matrix,
    List<String>? formattedPairs,
    bool? isAnimating,
    int? activePairIndex,
    List<int>? activeMatrixIndices,
    List<int>? targetMatrixIndices,
    String? currentEquation,
    bool clearIndices = false,
  }) {
    return PlayfairState(
      inputText: inputText ?? this.inputText,
      keyword: keyword ?? this.keyword,
      outputText: outputText ?? this.outputText,
      matrix: matrix ?? this.matrix,
      formattedPairs: formattedPairs ?? this.formattedPairs,
      isAnimating: isAnimating ?? this.isAnimating,
      activePairIndex: clearIndices
          ? null
          : (activePairIndex ?? this.activePairIndex),
      activeMatrixIndices: clearIndices
          ? const []
          : (activeMatrixIndices ?? this.activeMatrixIndices),
      targetMatrixIndices: clearIndices
          ? const []
          : (targetMatrixIndices ?? this.targetMatrixIndices),
      currentEquation: currentEquation ?? this.currentEquation,
    );
  }
}
