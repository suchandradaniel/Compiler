#include <stdio.h>
#include <stdbool.h>

int main() {
    char ch;
    bool inWord = false;
    int charCount = 0, wordCount = 0, lineCount = 0;

    printf("Enter text (press Ctrl+D or Ctrl+Z to end input):\n");

    while ((ch = getchar()) != EOF) {
        charCount++;

        if (ch == ' ' || ch == '\n' || ch == '\t' || ch == '\r') {
            if (inWord) {
                wordCount++;
                inWord = false;
            }

            if (ch == '\n') {
                lineCount++;
            }
        } else {
            inWord = true;
        }
    }


    if (inWord) {
        wordCount++;
    }

    printf("Number of characters: %d\n", charCount);
    printf("Number of words: %d\n", wordCount);
    printf("Number of lines: %d\n", lineCount);

    return 0;
}