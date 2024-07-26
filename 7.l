%{
#include <stdio.h>

// Define constants for maximum length of numbers and words
#define MAX_LENGTH 100

// Buffers to hold the lists of numbers and words
char numbers_list[MAX_LENGTH * 10] = {0};  // Assume 10 numbers at most
char words_list[MAX_LENGTH * 10] = {0};    // Assume 10 words at most

void append_to_list(char *list, const char *item) {
    if (strlen(list) + strlen(item) + 2 < sizeof(list)) {  // +2 for space and newline
        strcat(list, item);
        strcat(list, " ");
    }
}
%}

%%

[0-9]+          { append_to_list(numbers_list, yytext); }
[a-zA-Z]+        { append_to_list(words_list, yytext); }
[ \t\n]+         { /* Ignore whitespace */ }
.                { /* Ignore other characters */ }

%%

int main(int argc, char **argv) {
    yylex();  // Start the lexical analyzer

    // Print the lists
    printf("Numbers List:\n%s\n", numbers_list);
    printf("Words List:\n%s\n", words_list);

    return 0;
}
