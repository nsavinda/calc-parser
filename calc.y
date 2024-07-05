%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <math.h>
    #include <unistd.h>

    #define DEBUG 0

    #define DEBUG_PRINT(fmt, ...) \
        do { if (DEBUG) fprintf(stderr, fmt, __VA_ARGS__); } while (0)

%}

%token NUMBER
%token ADD SUB MUL DIV POW LEFTP RIGHTP EOL 

%left ADD SUB
%left MUL DIV
%right POW

%start input


%%
input:
    | input line
;

line:
    expr EOL { 
        DEBUG_PRINT("line: %d\n", $1);
        printf("Result: %d\n",$1);
        }
;

expr:
    expr ADD term {
        DEBUG_PRINT("expr ADD term: %d\n", $1 + $3);
        $$ = $1 + $3;
        }
    | expr SUB term { 
        DEBUG_PRINT("expr SUB term: %d\n", $1 - $3);
        $$ = $1 - $3;
        }
    | term {
        DEBUG_PRINT("term: %d\n", $1);
        $$ = $1;
        }
;

term:
    term MUL factor {
        DEBUG_PRINT("term MUL factor: %d\n", $1 * $3);
        $$ = $1 * $3;
        }
    | term DIV factor {
        DEBUG_PRINT("term DIV factor: %d\n", $1 / $3);
        $$ = $1 / $3;
        }
    | factor {
        DEBUG_PRINT("factor: %d\n", $1);
        $$ = $1;
        }
;

factor:
    power {
        DEBUG_PRINT("factor: %d\n", $1);
        $$ = $1;
    }
;


power:
    primary POW power {
        DEBUG_PRINT("power POW primary: %f\n", pow($1, $3));
        $$ = pow($1, $3);
    }
    | primary {
        DEBUG_PRINT("primary: %d\n", $1);
        $$ = $1;
    }
;


primary:
    LEFTP expr RIGHTP {
        DEBUG_PRINT("primary: %d\n", $2);
        $$ = $2;
    }
    | SUB primary {
        DEBUG_PRINT("primary: %d\n", -$2);
        $$ = -($2);
    }
    | NUMBER
;


%%

int main() {
 if (isatty(STDIN_FILENO)) {
        printf("Enter expression: \n");
    }    yyparse();
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

