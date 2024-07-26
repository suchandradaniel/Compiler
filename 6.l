%{
#include <stdio.h>

int positive_count = 0;
int negative_count = 0;
%}

%%

[+-]?[0-9]+      {
                    if (yytext[0] == '-') {
                        negative_count++;
                    } else {
                        positive_count++;
                    }
                 }
[ \t\n]+         ;  // Ignore whitespace
.                { /* Ignore other characters */ }

%%

int main(int argc, char **argv) {
    yylex();  // Start the lexical analyzer
    printf("Number of positive numbers: %d\n", positive_count);
    printf("Number of negative numbers: %d\n", negative_count);
    return 0;
}
