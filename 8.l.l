%{
#include <stdio.h>
%}

%%

^[aeiouAEIOU][a-zA-Z0-9_]*   printf("Valid string starting with a vowel: %s\n", yytext);
.                             printf("Invalid string: %s\n", yytext);

%%

int yywrap() {
    return 1; // Indicate no more input files
}

int main(int argc, char *argv[]) {
    // Flex generated code expects this function to be called to initialize the scanner
    yylex();
    return 0;
}
