%{
#include <stdio.h>

// Counter for line numbers
int line_number = 1;

// Function to print a line with its line number
void print_line(const char *line) {
    printf("%d: %s", line_number, line);
}
%}

%%

\n              { line_number++; }          // Increment line number on newline
.               { putchar(yytext[0]); }     // Print characters as is
[ \t]+          { /* Ignore whitespace */ } // Ignore spaces and tabs

%%

int main(int argc, char **argv) {
    yylex();  // Start the lexical analyzer
    return 0;
}
