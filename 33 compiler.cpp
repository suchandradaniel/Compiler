#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define SIZE 100

struct Symbol {
    char name[50];
    char type[10];
    int scope;
    struct Symbol *next;
};

struct SymbolTable {
    struct Symbol *table[SIZE];
};

int hash(char *name) {
    int hashValue = 0;
    while (*name)
        hashValue += *name++;
    return hashValue % SIZE;
}

struct SymbolTable* createTable() {
    struct SymbolTable newTable = (struct SymbolTable) malloc(sizeof(struct SymbolTable));
    for (int i = 0; i < SIZE; i++)
        newTable->table[i] = NULL;
    return newTable;
}

void insert(struct SymbolTable *symTable, char *name, char *type, int scope) {
    int index = hash(name);
    struct Symbol newSymbol = (struct Symbol) malloc(sizeof(struct Symbol));
    strcpy(newSymbol->name, name);
    strcpy(newSymbol->type, type);
    newSymbol->scope = scope;
    newSymbol->next = symTable->table[index];
    symTable->table[index] = newSymbol;
}

struct Symbol* search(struct SymbolTable *symTable, char *name) {
    int index = hash(name);
    struct Symbol *current = symTable->table[index];
    while (current) {
        if (strcmp(current->name, name) == 0)
            return current;
        current = current->next;
    }
    return NULL;
}

void display(struct SymbolTable *symTable) {
    for (int i = 0; i < SIZE; i++) {
        struct Symbol *current = symTable->table[i];
        if (current) {
            printf("Index %d:\n", i);
            while (current) {
                printf("\tName: %s, Type: %s, Scope: %d\n", current->name, current->type, current->scope);
                current = current->next;
            }
        }
    }
}

int main() {
    struct SymbolTable *symTable = createTable();
    insert(symTable, "x", "int", 1);
    insert(symTable, "y", "float", 2);
    insert(symTable, "z", "char", 1);

    display(symTable);

    struct Symbol *sym = search(symTable, "y");
    if (sym)
        printf("Found %s of type %s in scope %d\n", sym->name, sym->type, sym->scope);
    else
        printf("Symbol not found\n");

    return 0;
}