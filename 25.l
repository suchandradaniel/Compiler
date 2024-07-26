%{
#include <stdio.h>
#include <string.h>

// The word to count
char target_word[] = "word";
int word_count = 0;

// Function to handle matching the target word
void count_word() {
    word_count++;
}
%}

%option noyywrap

// Definitions for tokens and patterns
%%
{target_word}   { count_word(); }
[ \t\n]+        { /* Ignore whitespace */ }
[a-zA-Z0-9_]+   { /* Ignore other words */ }
.               { /* Ignore other characters */ }
%%

int main(int argc, char **argv) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <input_file>\n", argv[0]);
        return 1;
    }

    // Open the input file
    FILE *input_file = fopen(argv[1], "r");
    if (!input_file) {
        perror("Error opening input file");
        return 1;
    }

    // Set the input stream to the input file
    yyin = input_file;

    // Start the lexical analyzer
    yylex();

    // Close the input file
    fclose(input_file);

    // Print the count of the target word
    printf("Frequency of the word '%s': %d\n", target_word, word_count);

    return 0;
}
