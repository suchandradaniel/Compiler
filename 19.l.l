%{
#include <stdio.h>

// Counters
int macro_count = 0;
int include_count = 0;

// Function to increment counters
void count_macro() {
    macro_count++;
}

void count_include() {
    include_count++;
}
%}

%%

#include            { count_include(); }  // Increment count for header file inclusions
#define             { count_macro(); }    // Increment count for macro definitions
[ \t\n]+           { /* Ignore whitespace */ }  // Ignore spaces, tabs, and newlines
.                  { /* Ignore other characters */ }  // Ignore other characters

%%

int main(int argc, char **argv) {
    yylex();  // Start the lexical analyzer

    // Print the results
    printf("Number of macros defined: %d\n", macro_count);
    printf("Number of header files included: %d\n", include_count);

    return 0;
}
