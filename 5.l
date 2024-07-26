%{
#include <stdio.h>
#include <string.h>

#define MAX_KEYWORDS 10

// List of keywords
const char *keywords[MAX_KEYWORDS] = {
    "if", "else", "while", "for", "return", "int", "float", "char", "void", "struct"
};

// Function to check if a token is a keyword
int is_keyword(const char *token) {
    for (int i = 0; i < MAX_KEYWORDS; i++) {
        if (strcmp(token, keywords[i]) == 0) {
            return 1;
        }
    }
    return 0;
}
%}

%%

[ \t\n]+            ;  // Ignore whitespace
if|else|while|for|return|int|float|char|void|struct  {
                        printf("Keyword: %s\n", yytext);
                    }
[a-zA-Z_][a-zA-Z0-9_]* {
                        if (is_keyword(yytext)) {
                            printf("Keyword: %s\n", yytext);
                        } else {
                            printf("Identifier: %s\n", yytext);
                        }
                    }
.                   ;  // Ignore other characters

%%

int main(int argc, char **argv) {
    yylex();  // Start the lexical analyzer
    return 0;
}
