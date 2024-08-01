#include <stdio.h>
#include <ctype.h>

void lexicalAnalysis(char* str) {
    int charCount = 0, wordCount = 0, lineCount = 0;
    int inWord = 0;
    
    while (*str) {
        charCount++;
        if (*str == '\n') {
            lineCount++;
            inWord = 0;
        } else if (isspace(*str)) {
            inWord = 0;
        } else if (!inWord) {
            inWord = 1;
            wordCount++;
        }
        str++;
    }
    
    if (charCount > 0 && str[-1] != '\n')
        lineCount++;
    
    printf("Characters: %d\nWords: %d\nLines: %d\n", charCount, wordCount, lineCount);
}

int main() {
    char str[1000];
    printf("Enter the input string (end with CTRL+D):\n");
    fgets(str, 1000, stdin);
    lexicalAnalysis(str);
    return 0;
}