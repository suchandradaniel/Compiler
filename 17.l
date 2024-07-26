%{
#include <stdio.h>
#include <string.h>

// Counters
int char_count = 0;
int line_count = 0;
int word_count = 0;

// Function to process words
void process_word(const char *word) {
    // Count words if the word is not empty
    if (strlen(word) > 0) {
        word_count++;
    }
}
%}

%%

\n              { line_count++; }             // Increment line count on newline
[ \t]+          { /* Ignore whitespace */ }   // Ignore spaces and tabs
[a-zA-Z_][a-zA-Z0-9_]* { process_word(yytext); } // Count alphanumeric words and underscores
.               { char_count++; }              // Count every character

%%

int main(int argc, char **argv) {
    yylex();  // Start the lexical analyzer
    // Print the results
    printf("Number of characters: %d\n", char_count);
    printf("Number of lines: %d\n", line_count);
    printf("Number of words: %d\n", word_count);
    return 0;
}
