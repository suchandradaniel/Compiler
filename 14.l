%{
#include <stdio.h>
#include <stdlib.h>

int num1, num2;
char op;

// Function to perform the arithmetic operation
void perform_operation() {
    int result;
    switch (op) {
        case '+':
            result = num1 + num2;
            break;
        case '-':
            result = num1 - num2;
            break;
        case '*':
            result = num1 * num2;
            break;
        case '/':
            if (num2 != 0) {
                result = num1 / num2;
            } else {
                printf("Error: Division by zero\n");
                return;
            }
            break;
        default:
            printf("Error: Unsupported operator\n");
            return;
    }
    printf("%d %c %d = %d\n", num1, op, num2, result);
}
%}

%%

[0-9]+          { 
                    if (num1 == 0) {
                        num1 = atoi(yytext); 
                    } else {
                        num2 = atoi(yytext); 
                    }
                 }
[+\-*/]          { op = yytext[0]; }
[ \t\n]+         { /* Ignore whitespace */ }
.                { /* Ignore other characters */ }

%%

int main(int argc, char **argv) {
    num1 = num2 = 0;  // Initialize numbers
    yylex();  // Start the lexical analyzer
    if (num1 != 0 && num2 != 0 && op) {
        perform_operation();
    } else {
        printf("Error: Invalid expression\n");
    }
    return 0;
}
