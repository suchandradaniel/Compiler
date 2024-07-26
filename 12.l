%{
#include <stdio.h>
#include <string.h>

// Function to print recognized words
void print_word(const char *word) {
    printf("Word: %s\n", word);
}

// Function to print recognized relational operators
void print_relational_operator(const char *op) {
    printf("Relational Operator: %s\n", op);
}
%}

%%

[a-zA-Z]+        { print_word(yytext); }  // Matches words
==|!=|<=|>=|<|> { print_relational_operator(yytext); }  // Matches relational operators
[ \t\n]+         { /* Ignore whitespace */ }
.                { /* Ignore other characters */ }

%%

int main(int argc, char **argv) {
    yylex();  // Start the lexical analyzer
    return 0;
}
