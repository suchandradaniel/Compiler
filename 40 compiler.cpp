#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>  // Include this header for isdigit

int regCount = 0;

void generateAssembly(char* expr) {
    char output[1000] = "";
    int i = 0;
    while (expr[i] != '\0') {
        if (isdigit(expr[i])) {
            char temp[10];
            sprintf(temp, "R%d", regCount++);
            strcat(output, temp);
            strcat(output, " = ");
            while (isdigit(expr[i])) {
                strncat(output, &expr[i], 1);
                i++;
            }
            strcat(output, "\n");
        } else if (expr[i] == '+' || expr[i] == '-' || expr[i] == '*' || expr[i] == '/') {
            char temp[10];
            sprintf(temp, "R%d", regCount++);
            strcat(output, temp);
            strcat(output, " = R");
            sprintf(temp, "%d", regCount - 2);
            strcat(output, temp);
            strncat(output, &expr[i], 1);
            strcat(output, " R");
            sprintf(temp, "%d", regCount - 3);
            strcat(output, temp);
            strcat(output, "\n");
            i++;
        } else {
            i++;
        }
    }
    printf("%s", output);
}

int main() {
    char expr[100];
    printf("Enter an arithmetic expression: ");
    scanf("%[^\n]%*c", expr);
    generateAssembly(expr);
    return 0;
}