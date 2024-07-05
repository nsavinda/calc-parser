%{
    #include "calc.tab.h"
    #include <math.h>

%}

digit [0-9]
%%
[ \t] ;
\n return EOL;
"+" return ADD;
"-" return SUB;
"*" return MUL;
"^" return POW;
"/" return DIV;
"(" return LEFTP;
")" return RIGHTP;
{digit}+ { yylval = atoi(yytext); return NUMBER; }
. return yytext[0];
%%
int yywrap() {
    return 1;
}