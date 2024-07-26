%{
#include <stdio.h>

// Counters
int block_comment_count = 0;
int line_comment_count = 0;

// File pointer for output
FILE *output_file;

// Function to handle block comments
void handle_block_comment() {
    block_comment_count++;
}

// Function to handle line comments
void handle_line_comment() {
    line_comment_count++;
}

// Function to print code without comments to the output file
void write_to_output(const char *text) {
    fprintf(output_file, "%s", text);
}
%}

%%

/\*[^*]*\*+([^/*][^*]*\*+)*/ { handle_block_comment(); }  // Match block comments
//.*\n                       { handle_line_comment(); }     // Match line comments
[^/]*  { write_to_output(yytext); }   // Match and write non-comment text to the output file
.      { /* Ignore other characters */ }  // Ignore other characters

%%

int main(int argc, char **argv) {
    if (argc != 3) {
        fprintf(stderr, "Usage: %s <input_file> <output_file>\n", argv[0]);
        return 1;
    }

    // Open the output file
    output_file = fopen(argv[2], "w");
    if (!output_file) {
        perror("Error opening output file");
        return 1;
    }

    // Process the input file
    FILE *input_file = fopen(argv[1], "r");
    if (!input_file) {
        perror("Error opening input file");
        fclose(output_file);
        return 1;
    }

    // Set the input stream to the input file
    yyin = input_file;

    // Start the lexical analyzer
    yylex();

    // Close files
    fclose(input_file);
    fclose(output_file);

    // Print the counts of comment lines
    printf("Number of block comment lines: %d\n", block_comment_count);
    printf("Number of line comment lines: %d\n", line_comment_count);

    return 0;
}
