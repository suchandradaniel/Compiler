%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Function to print HTML tags
void print_tag(const char *tag) {
    printf("HTML Tag: %s\n", tag);
}
%}

%%

<[^>]+>          { print_tag(yytext); }  // Match and print HTML tags
[ \t\n]+         { /* Ignore whitespace */ }  // Ignore spaces, tabs, and newlines
.                { /* Ignore other characters */ }  // Ignore other characters

%%

int main(int argc, char **argv) {
    yylex();  // Start the lexical analyzer
    return 0;
}
