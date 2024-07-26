%{
#include <stdio.h>
%}

%%

[0-9]+        { printf("Input is a digit: %s\n", yytext); }
.              { printf("Input is not a digit.\n"); }

%%

int main(int argc, char **argv) {
    yylex();  // Start the lexical analyzer
    return 0;
}
