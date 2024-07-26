%{
#include <stdio.h>
%}

%%

[A-Z]+          { printf("Capital Word: %s\n", yytext); }

.|\n            { /* ignore other characters */ }

%%

int main(void) {
    yylex();
    return 0;
}

int yywrap(void) {
    return 1;
}