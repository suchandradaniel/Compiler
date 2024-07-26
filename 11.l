%{
#include <stdio.h>
#include <stdlib.h>

// Prototype declaration for isValidDate function
int isValidDate(int year, int month, int day);

%}

%option noyywrap

DIGIT [0-9]
YEAR {DIGIT}{4}
MONTH (0[1-9]|1[0-2])
DAY (0[1-9]|[1-2][0-9]|3[0-1])

%%

{YEAR}-{MONTH}-{DAY} {
    int year = atoi(yytext);
    int month = atoi(yytext + 5);
    int day = atoi(yytext + 8);

    if (isValidDate(year, month, day)) {
        printf("Valid date of birth: %s\n", yytext);
    } else {
        printf("Invalid date of birth: %s\n", yytext);
    }
}

.|\n {
    printf("Error: Invalid date format or characters: %s\n", yytext);
}

%%

// Function to validate the date
int isValidDate(int year, int month, int day) {
    // Basic validation of the date
    if (year < 1900 || year > 9999) {
        return 0; // Invalid year
    }
    if (month < 1 || month > 12) {
        return 0; // Invalid month
    }
    if (day < 1 || day > 31) {
        return 0; // Invalid day
    }
    // Additional checks for specific months (like February for leap years) could be added here if needed

    return 1; // Date is valid
}

int main(int argc, char *argv[]) {
    // Flex-generated code expects this function to initialize the scanner
    yylex();
    return 0;
}
