%{
#include <stdio.h>
#include <string.h>

void check_mobile_number(const char *number) {
    // Define a pattern for validating a 10-digit mobile number
    const char *pattern = "^[0-9]{10}$";
    
    // Use regex to validate the number
    regex_t regex;
    regmatch_t match[1];
    
    if (regcomp(&regex, pattern, REG_EXTENDED) != 0) {
        printf("Regex compilation failed\n");
        return;
    }
    
    if (regexec(&regex, number, 1, match, 0) == 0) {
        printf("Valid mobile number: %s\n", number);
    } else {
        printf("Invalid mobile number: %s\n", number);
    }
    
    regfree(&regex);
}
%}

%%

([+]?[0-9]{1,3}[ -]?)?[0-9]{10}   {
    // Remove any non-digit characters (e.g., +1, spaces, hyphens)
    char cleaned_number[11] = {0};
    int j = 0;
    
    for (int i = 0; i < yyleng; i++) {
        if (yytext[i] >= '0' && yytext[i] <= '9') {
            cleaned_number[j++] = yytext[i];
        }
    }
    
    if (j == 10) {
        cleaned_number[j] = '\0';  // Null-terminate the cleaned number
        check_mobile_number(cleaned_number);
    } else {
        printf("Invalid mobile number: %s\n", yytext);
    }
}

.   { /* Ignore other characters */ }

%%

int main(int argc, char **argv) {
    yylex();  // Start the lexical analyzer
    return 0;
}
