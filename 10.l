%{
#include <stdio.h>
#include <string.h>

void print_valid_url(const char *url) {
    printf("Valid URL: %s\n", url);
}
%}

%%

(http|https|ftp)://
([a-zA-Z0-9._-]+)          // Domain name
(:[0-9]+)?                // Optional port number
(/[a-zA-Z0-9._/-]*)?      // Optional path
(\?[a-zA-Z0-9&=_-]*)?     // Optional query
(#\w*)?                   // Optional fragment
{
    print_valid_url(yytext);
}

. { /* Ignore other characters */ }

%%

int main(int argc, char **argv) {
    yylex();  // Start the lexical analyzer
    return 0;
}
