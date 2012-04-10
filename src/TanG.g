grammar TanG;

options{
language = Ruby;
output=AST;
ASTLabelType=CommonTree;
}

Start	:	I* M;

fragment
I	:	FROM (ID '.td') IMPORT (ID ('.' ID)* | '*') NEWLINE| IMPORT ID '.td' NEWLINE;

fragment
M	:	(Statement NEWLINE)*;

fragment
Statement
	:	NODE ID '(' Params ')' NEWLINE M NEWLINE END
	|	Expression
	|	ID ('[' (ID|INT|STRING|FLOAT) ']')* '=' Expression
	|	LoopType
	|	RETURN Expression
	|	ASSERT Expression;

fragment
Params	:	ID (',' ID)*;

fragment
LoopType:	FOR ID IN Iterable NEWLINE (LoopStatement NEWLINE)* END
	| WHILE Expression NEWLINE (LoopStatement NEWLINE)* END
	| DO NEWLINE (LoopStatement NEWLINE)* WHILE Expression NEWLINE END
	| LOOP NEWLINE (LoopStatement NEWLINE)* END
	| UNTIL Expression NEWLINE (LoopStatement NEWLINE)* END;

fragment
Iterable:	'You can iterate through me';

fragment
LoopStatement
	:NODE ID '(' Params ')' NEWLINE M NEWLINE END 
	| BREAK (Expression)? 
	| CONTINUE 
	| LoopExpression
	| ID ('[' (ID|INT|STRING|FLOAT) ']')* '=' Expression
	| RETURN Expression
	| ASSERT Expression;



fragment
Atom	:	ID ('[' (ID|INT|STRING|FLOAT) ']')*|FLOAT|INT|'(' Expression ')'|STRING;


//Expression section
fragment
Expression
	:	CondType|XorExpr ('or' XorExpr)*;

fragment
XorExpr	:	AndExpr ('xor' AndExpr)*;

fragment
AndExpr	:	NotExpr ('and' NotExpr);

fragment
NotExpr	:	'not' MemExpr;

fragment
MemExpr	:	IDTestExpr (('in'|'not in') IDTestExpr)?;

fragment
IDTestExpr
	:	'This is an Identity test';


fragment
LoopExpression
	:	'this is totally like a loop expression man... need those breaks in conds bro';
 
 fragment
 CondType
 	:	'This is a conditional statement';
 
fragment
BREAK	:	'break';

fragment
CONTINUE:	'continue'; 
 
fragment
FROM
	:	'from'
	;
fragment
IMPORT
	:	'import'
	;
fragment
NODE
	:	'node'
	;
fragment
END
	:	'end'
	;
fragment
RETURN
	:	'return'
	;
fragment
ASSERT
	:	'assert'
	;
fragment
FOR
	:	'for'
	;
fragment
IN
	:	'in'
	;
fragment
WHILE
	:	'while'
	;
fragment
DO
	:	'do'
	;
fragment
LOOP
	:	'loop'
	;
fragment
UNTIL
	:	'until'
	;


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
