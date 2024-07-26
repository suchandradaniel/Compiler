%{
#include <stdio.h>

int vowel_count = 0;
int consonant_count = 0;
%}

%%

[aeiouAEIOU]   { vowel_count++; }
[b-df-hj-np-tv-zB-DF-HJ-NP-TV-Z] { consonant_count++; }
[ \t\n]        { /* Ignore whitespace */ }
.              { /* Ignore other characters */ }

%%

int main(int argc, char **argv) {
    yylex();  // Start the lexical analyzer
    printf("Number of vowels: %d\n", vowel_count);
    printf("Number of consonants: %d\n", consonant_count);
    return 0;
}
