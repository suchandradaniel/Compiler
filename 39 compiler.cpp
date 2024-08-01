#include <stdio.h>
#include <string.h>
#include <stdlib.h>

struct Expression {
    char lhs[10];
    char rhs[10];
};

void eliminateCommonSubexpressions(struct Expression* exprs, int n) {
    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            if (strcmp(exprs[i].rhs, exprs[j].rhs) == 0) {
                strcpy(exprs[j].rhs, exprs[i].lhs);
            }
        }
    }

    for (int i = 0; i < n; i++) {
        printf("%s = %s\n", exprs[i].lhs, exprs[i].rhs);
    }
}

int main() {
    int n;
    printf("Enter the number of expressions: ");
    scanf("%d", &n);

    struct Expression exprs[n];
    for (int i = 0; i < n; i++) {
        printf("Enter expression %d (format: lhs=rhs): ", i + 1);
        scanf("%s = %s", exprs[i].lhs, exprs[i].rhs);
    }

    eliminateCommonSubexpressions(exprs, n);

    return 0;
}