#include <stdio.h>
#include <stdbool.h>
#include <string.h>

bool isValid(char *str) {
    int state = 0;
    for (int i = 0; str[i] != '\0'; i++) {
        char ch = str[i];
        switch (state) {
            case 0:
                if (ch == 'a')
                    state = 1;
                else
                    return false;
                break;
            case 1:
                if (ch == 'b')
                    state = 2;
                else
                    return false;
                break;
            case 2:
                if (ch == 'c')
                    state = 3;
                else
                    return false;
                break;
            case 3:
                return false;
        }
    }
    return state == 3;
}

int main() {
    char str[100];
    printf("Enter a string: ");
    scanf("%s", str);

    if (isValid(str))
        printf("The string is valid.\n");
    else
        printf("The string is invalid.\n");

    return 0;
}