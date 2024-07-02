%{
    #include <stdio.h>
    #include <stdlib.h>
%}

%token NUMBER
%token ADD SUB MUL DIV LEFTP RIGHTP EOL


%%
input:
    | input line
;

line:
    expr EOL { printf("Result: %d\n",$1);}
;

expr:
    expr ADD term {$$ = $1 + $3;}
    | expr SUB term { $$ = $1 - $3;}
    | term {$$ = $1;}
;

term:
    term MUL factor {$$ = $1 * $3;}
    | term DIV factor {$$ = $1 / $3;}
    | factor {$$ = $1;}
;

factor:
    LEFTP expr RIGHTP {$$ = $2;}
    | SUB expr {$$ = -($2);}
    | NUMBER
;

%%

int main() {
    printf("Enter expression: \n");
    yyparse();
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
