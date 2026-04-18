part of 'caesar_cubit.dart';

class CaesarState {
  final String inputText;
  final String outputText;
  final int shiftKey;

  final bool isAnimating;
  final bool isTracing;
  final int? activeInputIndex;
  final int? activeGridIndex;
  final String currentEquation;

  const CaesarState({
    this.inputText = '',
    this.outputText = '',
    this.shiftKey = 10,
    this.isAnimating = false,
    this.isTracing = false,
    this.activeInputIndex,
    this.activeGridIndex,
    this.currentEquation = '',
  });

  CaesarState copyWith({
    String? inputText,
    String? outputText,
    int? shiftKey,
    bool? isAnimating,
    bool? isTracing,
    int? activeInputIndex,
    int? activeGridIndex,
    String? currentEquation,
    bool clearIndices = false,
  }) {
    return CaesarState(
      inputText: inputText ?? this.inputText,
      outputText: outputText ?? this.outputText,
      shiftKey: shiftKey ?? this.shiftKey,
      isAnimating: isAnimating ?? this.isAnimating,
      isTracing: isTracing ?? this.isTracing,
      activeInputIndex: clearIndices
          ? null
          : (activeInputIndex ?? this.activeInputIndex),
      activeGridIndex: clearIndices
          ? null
          : (activeGridIndex ?? this.activeGridIndex),
      currentEquation: currentEquation ?? this.currentEquation,
    );
  }
}
