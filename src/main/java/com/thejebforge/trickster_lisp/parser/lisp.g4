grammar lisp;

root : preprocessor* sExpression* EOF;

sExpression :
    EMPTY
    | VOID
    | BOOLEAN
    | OPERATOR
    | INTEGER
    | FLOAT
    | STRING
    | IDENTIFIER
    | macroCall
    | GREEDY
    | call
    | list
    | map;

preprocessor :
    '(' '#def' name=IDENTIFIER '(' args+=IDENTIFIER* GREEDY? ')' substitute=sExpression ')' # macro;

macroCall : '(' name=IDENTIFIER '!' args+=sExpression* ')';

call : '(' subject=sExpression args+=sExpression* ')';

list : '[' sExpression? (',' sExpression)* ']';

mapEntry : key=sExpression ':' value=sExpression;
map : '{' mapEntry? (',' mapEntry)* '}';

EMPTY : '_';
VOID : 'void';
BOOLEAN : 'true' | 'false';
INTEGER : '-'? [0-9]+;
FLOAT : '-'? ('0'..'9')+ '.' ('0'..'9')* EXPONENT?
        | '-'? '.' ('0'..'9')+ EXPONENT?
        | '-'? ('0'..'9')+ EXPONENT;
STRING :  '"' ( ESC_SEQ | ~('\\'|'"') )* '"';
OPERATOR : ('!'|'@'|'#'|'$'|'%'|'^'|'&'|'*'|'?'|'+'|'-'|'<'|'>'|'='|':'|'/'|'|')+;
IDENTIFIER : [a-zA-Z] [a-zA-Z0-9:_-]*;
GREEDY : '...';

fragment EXPONENT : ('e'|'E') ('+'|'-')? ('0'..'9')+;

fragment HEX_DIGIT : ('0'..'9'|'a'..'f'|'A'..'F');

fragment ESC_SEQ : '\\' ('b'|'t'|'n'|'f'|'r'|'"'|'\''|'\\')
    | UNICODE_ESC
    | OCTAL_ESC;

fragment OCTAL_ESC : '\\' ('0'..'3') ('0'..'7') ('0'..'7')
   | '\\' ('0'..'7') ('0'..'7')
   | '\\' ('0'..'7');

fragment UNICODE_ESC : '\\' 'u' HEX_DIGIT HEX_DIGIT HEX_DIGIT HEX_DIGIT;

WS: [ \r\n\t]+ -> skip;
LINE_COMMENT : ';' ~( '\n'|'\r' )* '\r'? '\n' -> skip;