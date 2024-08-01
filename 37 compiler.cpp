#include <stdio.h>
#include <string.h>
#include <ctype.h>

int tempVarCount = 0;

void generateTAC(char* expr) {
    char output[100] = "";
    int i = 0, j = 0;
    while (expr[i] != '\0') {
        if (isdigit(expr[i])) {
            char temp[10];
            sprintf(temp, "t%d", tempVarCount++);
            strcat(output, temp);
            strcat(output, " = ");
            while (isdigit(expr[i])) {
                strncat(output, &expr[i], 1);
                i++;
            }
            strcat(output, "\n");
        } else if (expr[i] == '+' || expr[i] == '-' || expr[i] == '*' || expr[i] == '/') {
            char temp[10];
            sprintf(temp, "t%d", tempVarCount++);
            strcat(output, temp);
            strcat(output, " = t");
            sprintf(temp, "%d", tempVarCount - 2);
            strcat(output, temp);
            strncat(output, &expr[i], 1);
            strcat(output, " t");
            sprintf(temp, "%d", tempVarCount - 3);
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
    generateTAC(expr);
    return 0;
}