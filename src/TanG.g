grammar TanG;

Start	:	I* M;

fragment
I	:	'from' (ID '.td') 'import' (ID ('.' ID)* | '*') NEWLINE| 'import' ID '.td' NEWLINE;

fragment
M	:	(Statement NEWLINE)*;

fragment
Statement
	:	'node' ID '(' Params ')' NEWLINE M NEWLINE 'end'
	|	Expression
	|	ID '=' Expression
	|	LoopType
	|	'return' Expression
	|	'assert' Expression;

fragment
Params	:	ID (',' ID)*;

fragment
LoopType:	'for' ID 'in' Iterable NEWLINE (LoopStatement NEWLINE)* 'end'
	| 'while' Expression NEWLINE (LoopStatement NEWLINE)* 'end'
	| 'do' NEWLINE (LoopStatement NEWLINE)* 'while' Expression NEWLINE 'end'
	| 'loop' NEWLINE (LoopStatement NEWLINE)* 'end'
	| 'until' Expression NEWLINE (LoopStatement NEWLINE)* 'end';

fragment
Iterable:	'You can iterate through me';

fragment
LoopStatement
	:	'These are loop statements';

fragment
Expression
	:	'jazz';





fragment
ID  :	('a'..'z'|'A'..'Z'|'_') ('a'..'z'|'A'..'Z'|'0'..'9'|'_')*
    ;

fragment
INT :	'0'..'9'+
    ;
    
fragment
FLOAT
    :   ('0'..'9')+ '.' ('0'..'9')* EXPONENT?
    |   '.' ('0'..'9')+ EXPONENT?
    |   ('0'..'9')+ EXPONENT
    ;

COMMENT
    :   '//' ~('\n'|'\r')* '\r'? '\n' {$channel=HIDDEN;}
    |   '/*' ( options {greedy=false;} : . )* '*/' {$channel=HIDDEN;}
    ;

fragment
NEWLINE	:	'\r'? '\n'
		;

WS  :   ( ' '
        | '\t'
        | '\r'
        | '\n'
        ) {$channel=HIDDEN;}
    ;

fragment
STRING
    :  '"' ( ESC_SEQ | ~('\\'|'"') )* '"'
    ;

fragment
EXPONENT : ('e'|'E') ('+'|'-')? ('0'..'9')+ ;

fragment
HEX_DIGIT : ('0'..'9'|'a'..'f'|'A'..'F') ;

fragment
ESC_SEQ
    :   '\\' ('b'|'t'|'n'|'f'|'r'|'\"'|'\''|'\\')
    |   UNICODE_ESC
    |   OCTAL_ESC
    ;

fragment
OCTAL_ESC
    :   '\\' ('0'..'3') ('0'..'7') ('0'..'7')
    |   '\\' ('0'..'7') ('0'..'7')
    |   '\\' ('0'..'7')
    ;

fragment
UNICODE_ESC
    :   '\\' 'u' HEX_DIGIT HEX_DIGIT HEX_DIGIT HEX_DIGIT
    ;
