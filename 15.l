%{
#include <stdio.h>
#include <string.h>

// Function to print valid email addresses
void print_valid_email(const char *email) {
    printf("Valid Email: %s\n", email);
}
%}

%%

[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,} {
    print_valid_email(yytext);
}

. { /* Ignore other characters */ }

%%

int main(int argc, char **argv) {
    yylex();  // Start the lexical analyzer
    return 0;
}
