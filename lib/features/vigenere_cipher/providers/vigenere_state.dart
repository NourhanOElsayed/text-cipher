part of 'vigenere_cubit.dart';

class VigenereState {
  final String inputText;
  final String outputText;
  final String keyword;

  final bool isAnimating;
  final int? activeInputIndex;
  final int? activeKeyIndex;
  final int? activeGridIndex;
  final bool isTracing;
  final String currentEquation;

  const VigenereState({
    this.inputText = '',
    this.outputText = '',
    this.keyword = '',
    this.activeInputIndex,
    this.activeKeyIndex,
    this.activeGridIndex,
    this.isAnimating = false,
    this.isTracing = false,
    this.currentEquation = '',
  });

  VigenereState copyWith({
    String? inputText,
    String? outputText,
    String? keyword,
    bool? isAnimating,
    bool? isTracing,
    int? activeInputIndex,
    int? activeKeyIndex,
    int? activeGridIndex,
    String? currentEquation,
    bool clearIndices = false,
  }) {
    return VigenereState(
      inputText: inputText ?? this.inputText,
      outputText: outputText ?? this.outputText,
      keyword: keyword ?? this.keyword,
      activeInputIndex: clearIndices
          ? null
          : (activeInputIndex ?? this.activeInputIndex),
      activeKeyIndex: clearIndices
          ? null
          : (activeKeyIndex ?? this.activeKeyIndex),
      activeGridIndex: clearIndices
          ? null
          : (activeGridIndex ?? this.activeGridIndex),
      isAnimating: isAnimating ?? this.isAnimating,
      isTracing: isTracing ?? this.isTracing,
      currentEquation: currentEquation ?? this.currentEquation,
    );
  }
}
