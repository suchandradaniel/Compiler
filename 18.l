%{
#include <stdio.h>
#include <stdlib.h>

// Function to print constants
void print_constant(const char *constant) {
    printf("Constant: %s\n", constant);
}
%}

%%

[0-9]+\.[0-9]+([eE][+-]?[0-9]+)? { print_constant(yytext); }  // Matches floating-point numbers
[0-9]+                         { print_constant(yytext); }  // Matches integers
[ \t\n]+                       { /* Ignore whitespace */ }  // Ignore whitespace
.                              { /* Ignore other characters */ }  // Ignore other characters

%%

int main(int argc, char **argv) {
    yylex();  // Start the lexical analyzer
    return 0;
}
