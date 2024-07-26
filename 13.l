%{
#include <stdio.h>
#include <string.h>

char word_to_replace[] = "word_to_replace";
char replacement_word[] = "replacement_word";
%}

%%
%{ 
int main(int argc, char *argv[]) {
    FILE *input, *output;
    char word[100]; // Adjust size as needed
    if (argc != 3) {
        fprintf(stderr, "Usage: %s <input-file> <output-file>\n", argv[0]);
        return 1;
    }
    input = fopen(argv[1], "r");
    if (input == NULL) {
        perror(argv[1]);
        return 1;
    }
    output = fopen(argv[2], "w");
    if (output == NULL) {
        perror(argv[2]);
        fclose(input);
        return 1;
    }
    while (fscanf(input, "%s", word) == 1) {
        if (strcmp(word, word_to_replace) == 0) {
            fprintf(output, "%s ", replacement_word);
        } else {
            fprintf(output, "%s ", word);
        }
    }
    fclose(input);
    fclose(output);
    return 0;
}
%}
%%
