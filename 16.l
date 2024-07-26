%{
#include <stdio.h>
#include <string.h>

// Function to handle the replacement
void replace_abc_with_ABC(const char *text) {
    // Print the transformed text
    printf("%s", text);
}
%}

%%

abc            { printf("ABC"); }  // Replace "abc" with "ABC"
.               { putchar(yytext[0]); }  // Print any other character as is

%%

int main(int argc, char **argv) {
    yylex();  // Start the lexical analyzer
    return 0;
}
