/*** Definition Section has one variable
which can be accessed inside yylex()
and main() ***/
%{
#include <stdio.h>
%}

/*** Rule Section has three rules ***/
%%
[A-Za-z]+ { printf("%s\n", yytext); } // Match words (alphabetic characters)
.         ; // Ignore other characters
\n        ; // Ignore newlines
%%

/*** Code Section ***/
int main() {
    // yywrap() - wraps the above rule section
    // yytext is the text in the buffer

    printf("Enter a sentence (press Enter to tokenize):\n");

    // Process input sentences
    while (1) {
        char sentence[1000]; // Adjust the buffer size as needed
        if (fgets(sentence, sizeof(sentence), stdin) == NULL) {
            break; // Exit on EOF
        }

        // Tokenize the sentence
        yy_scan_string(sentence);
        int token;
        while ((token = yylex()) != 0) {
            // 0 indicates the end of input
            if (token == '\n') {
                printf("\n"); // Add a newline between sentences
            }
        }
    }

    return 0;
}
