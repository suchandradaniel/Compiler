#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>
#include <string.h>  // Include this header for strlen

int precedence(char op) {
    switch (op) {
        case '+':
        case '-':
            return 1;
        case '*':
        case '/':
            return 2;
        case '^':
            return 3;
    }
    return 0;
}

int applyOp(int a, int b, char op) {
    switch (op) {
        case '+': return a + b;
        case '-': return a - b;
        case '*': return a * b;
        case '/': return a / b;
        case '^': {
            int result = 1;
            for (int i = 0; i < b; i++)
                result *= a;
            return result;
        }
    }
    return 0;
}

int evaluate(char* tokens) {
    int i;
    int values[100];
    char ops[100];
    int valTop = -1, opsTop = -1;

    for (i = 0; tokens[i]; i++) {
        if (tokens[i] == ' ')
            continue;

        else if (tokens[i] == '(') {
            ops[++opsTop] = tokens[i];
        }

        else if (isdigit(tokens[i])) {
            int val = 0;
            while (i < strlen(tokens) && isdigit(tokens[i])) {
                val = (val * 10) + (tokens[i] - '0');
                i++;
            }
            values[++valTop] = val;
            i--;
        }

        else if (tokens[i] == ')') {
            while (opsTop != -1 && ops[opsTop] != '(') {
                int val2 = values[valTop--];
                int val1 = values[valTop--];
                char op = ops[opsTop--];
                values[++valTop] = applyOp(val1, val2, op);
            }
            opsTop--;  // Pop the '(' from ops stack
        }

        else {
            while (opsTop != -1 && precedence(ops[opsTop]) >= precedence(tokens[i])) {
                int val2 = values[valTop--];
                int val1 = values[valTop--];
                char op = ops[opsTop--];
                values[++valTop] = applyOp(val1, val2, op);
            }
            ops[++opsTop] = tokens[i];
        }
    }

    while (opsTop != -1) {
        int val2 = values[valTop--];
        int val1 = values[valTop--];
        char op = ops[opsTop--];
        values[++valTop] = applyOp(val1, val2, op);
    }

    return values[valTop];
}

int main() {
    char expression[100];
    printf("Enter an expression: ");
    fgets(expression, sizeof(expression), stdin);
    // Remove newline character if it exists
    expression[strcspn(expression, "\n")] = 0;
    printf("Result: %d\n", evaluate(expression));
    return 0;
}