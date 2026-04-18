# TextCipher

TextCipher is an interactive, desktop-first cryptography visualizer built with Flutter. It is designed to demystify classic encryption algorithms by breaking down their mathematical and spatial mechanics into step-by-step, visually traceable animations. 

Rather than instantly outputting ciphertext, TextCipher acts as an educational tool, tracing the path from plaintext to ciphertext using dynamic grids, matrices, and real-time equation generation.

## Features

### Cryptography Visualizers
* **Caesar Cipher:** Visualizes a monoalphabetic substitution. Features a custom key slider and an interactive A-Z grid that traces the `(P + K) mod 26` mathematical shift in real-time.
* **Vigenère Cipher:** Demonstrates polyalphabetic substitution. Dynamically matches keyword length to the input text and animates the unique alphabet shift for each individual letter.
* **Playfair Cipher:** Explores spatial block cryptography. Automatically handles digraph formatting (merging I/J, padding with X) and visually executes the 5x5 matrix rules (same row, same column, rectangle swap) using color-coded coordinate tracking.
