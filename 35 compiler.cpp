#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>

char *input;
char lookahead;

void error() {
    printf("Error\n");
    exit(1);
}

void match(char token);
void F();
void T();
void E();

void match(char token) {
    if (lookahead == token)
        lookahead = *input++;
    else
        error();
}

void F() {
    if (isdigit(lookahead)) {
        while (isdigit(lookahead)) {
            lookahead = *input++;
        }
    } else if (lookahead == '(') {
        match('(');
        E();
        match(')');
    } else {
        error();
    }
}

void T() {
    F();
    while (lookahead == '*') {
        match('*');
        F();
    }
}

void E() {
    T();
    while (lookahead == '+') {
        match('+');
        T();
    }
}

int main() {
    char expr[100];
    printf("Enter an expression: ");
    scanf("%s", expr);

    input = expr;
    lookahead = *input++;
    E();
    if (lookahead == '\0')
        printf("Parsing successful\n");
    else
        printf("Parsing unsuccessful\n");

    return 0;
}