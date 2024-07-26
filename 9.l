%{
#include <stdio.h>
#include <string.h>

int max_length = 0;  // Variable to hold the length of the longest word
int current_length = 0;  // Variable to hold the length of the current word

void update_max_length() {
    if (current_length > max_length) {
        max_length = current_length;
    }
    current_length = 0;  // Reset current length for the next word
}
%}

%%

[a-zA-Z]+        {  // Match a word
                    current_length = strlen(yytext);  // Get the length of the current word
                    update_max_length();  // Update max_length if current_length is greater
                 }
[ \t\n]+         {  // Ignore whitespace and newlines
                    update_max_length();  // Handle the end of a word
                 }
.                {  // Ignore other characters
                    update_max_length();  // Handle the end of a word
                 }

%%

int main(int argc, char **argv) {
    yylex();  // Start the lexical analyzer
    // Print the length of the longest word
    printf("Length of the longest word: %d\n", max_length);
    return 0;
}
