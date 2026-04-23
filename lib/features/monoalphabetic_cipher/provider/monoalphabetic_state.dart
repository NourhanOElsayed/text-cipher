part of 'monoalphabetic_cubit.dart';

class MonoalphabeticState {
  final String inputText;
  final String keyAlphabet;
  final String outputText;
  final bool isAnimating;
  final int? activeInputIndex;
  final int? activeGridIndex;
  final bool isTracing;
  final String currentEquation;

  const MonoalphabeticState({
    this.inputText = '',
    this.keyAlphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
    this.outputText = '',
    this.isAnimating = false,
    this.activeInputIndex,
    this.activeGridIndex,
    this.isTracing = false,
    this.currentEquation = '',
  });

  MonoalphabeticState copyWith({
    String? inputText,
    String? keyAlphabet,
    String? outputText,
    bool? isAnimating,
    int? activeInputIndex,
    int? activeGridIndex,
    bool? isTracing,
    String? currentEquation,
    bool clearIndices = false,
  }) {
    return MonoalphabeticState(
      inputText: inputText ?? this.inputText,
      keyAlphabet: keyAlphabet ?? this.keyAlphabet,
      outputText: outputText ?? this.outputText,
      isAnimating: isAnimating ?? this.isAnimating,
      activeInputIndex: clearIndices ? null : (activeInputIndex ?? this.activeInputIndex),
      activeGridIndex: clearIndices ? null : (activeGridIndex ?? this.activeGridIndex),
      isTracing: isTracing ?? this.isTracing,
      currentEquation: currentEquation ?? this.currentEquation,
    );
  }
}