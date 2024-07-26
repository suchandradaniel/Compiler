%{
#include <stdio.h>
#include <ctype.h>

// Function prototypes
void print_token(const char *type, const char *value);

// Token type counters
int keyword_count = 0;
int identifier_count = 0;
int literal_count = 0;
int operator_count = 0;
int punctuation_count = 0;
%}

%option noyywrap

// Definitions for tokens and patterns
%%
#include                { print_token("Header File", yytext); }
int|float|double|char|void|if|else|for|while|return { print_token("Keyword", yytext); }
[ \t\n]+              { /* Ignore whitespace */ }
[a-zA-Z_][a-zA-Z0-9_]* { print_token("Identifier", yytext); }
"[^"]*"               { print_token("String Literal", yytext); }
[0-9]+(\.[0-9]+)?     { print_token("Numeric Literal", yytext); }
==|!=|<=|>=|<|>|&&|\|\| { print_token("Operator", yytext); }
[\+\-\*/%=\(\)\{\}\[\];,] { print_token("Punctuation", yytext); }
.                     { /* Ignore other characters */ }
%%

void print_token(const char *type, const char *value) {
    printf("%s: %s\n", type, value);
    
    // Count token types
    if (strcmp(type, "Keyword") == 0) {
        keyword_count++;
    } else if (strcmp(type, "Identifier") == 0) {
        identifier_count++;
    } else if (strcmp(type, "String Literal") == 0 || strcmp(type, "Numeric Literal") == 0) {
        literal_count++;
    } else if (strcmp(type, "Operator") == 0) {
        operator_count++;
    } else if (strcmp(type, "Punctuation") == 0) {
        punctuation_count++;
    }
}

int main(int argc, char **argv) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <input_file>\n", argv[0]);
        return 1;
    }

    // Open the input file
    FILE *input_file = fopen(argv[1], "r");
    if (!input_file) {
        perror("Error opening input file");
        return 1;
    }

    // Set the input stream to the input file
    yyin = input_file;

    // Start the lexical analyzer
    yylex();

    // Close the input file
    fclose(input_file);

    // Print the counts of each token type
    printf("\nSummary:\n");
    printf("Keywords: %d\n", keyword_count);
    printf("Identifiers: %d\n", identifier_count);
    printf("Literals: %d\n", literal_count);
    printf("Operators: %d\n", operator_count);
    printf("Punctuation: %d\n", punctuation_count);

    return 0;
}
