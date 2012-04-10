grammar TanG;

options{
language = Ruby;
output=AST;
ASTLabelType=CommonTree;
}

TanG	:	I* M;

fragment
I	:	FROM (ID '.td') IMPORT (ID ('.' ID)* | '*') NEWLINE| IMPORT ID '.td' NEWLINE;

fragment
M	:	(Statement NEWLINE)*;

fragment
Statement
	:	NODE WS ID WS '(' Params ')' NEWLINE M NEWLINE END
	|	Expression
	|	LoopType
	|	RETURN WS Expression
	|	ASSERT WS Expression;

fragment
Params	:	ID (',' ID)*;

fragment
LoopType:	FOR ID IN Iterable NEWLINE (LoopStatement NEWLINE)* END
	| WHILE WS Expression NEWLINE (LoopStatement NEWLINE)* END
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
	| RETURN WS Expression
	| ASSERT WS Expression;


//Expression section
fragment
Expression
	:	CondType|XorExpr (OR XorExpr)*;

fragment
XorExpr	:	AndExpr (XOR AndExpr)*;

fragment
AndExpr	:	NotExpr (AND NotExpr)*;

fragment
NotExpr	:	(NOT WS)? MemExpr;

fragment
MemExpr	:	IDTestExpr ((NOTIN | IN) IDTestExpr)?;

fragment
IDTestExpr
	:	ModExpr ((IS|ISNOT) ModExpr)?;
	
fragment
ModExpr	:	Assignment (MOD Assignment)*;

fragment
Assignment
	:	(RangeExpr '=')* RangeExpr;

fragment
RangeExpr
	:	NRangeExpr ('..' NRangeExpr)?;
	
fragment
NRangeExpr
	:	BoolAndExpr ('||' BoolAndExpr)*;
	
fragment
BoolAndExpr
	:	EqTestExpr ('&&' EqTestExpr)*;
fragment
EqTestExpr
	:	MagCompExpr (('=='|'!=') MagCompExpr)?;
	
fragment
MagCompExpr
	:	BitorExpr (('>'|'<'|'>='|'<=') BitorExpr)*;
	
fragment
BitorExpr
	:	BitXorExpr ('\\/' BitXorExpr)*;
	
fragment
BitXorExpr
	:	BitAndExpr ('^' BitAndExpr)*;
	
fragment
BitAndExpr
	:	'yayforbitand';

fragment
LoopExpression
	:	'@@@';
 
 fragment
 CondType
 	:	'###';
 
fragment
BREAK	:	'$$$';

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
OR
	:	'or'
	;
fragment
XOR
	:	'xor'
	;
fragment
AND
	:	'and'
	;
fragment
NOT
	:	'not'
	;
fragment
IS
	:	'is'
	;
fragment
ISNOT	:	'is not';
fragment
NOTIN	:	'not in';
fragment
MOD
	:	'mod'
	;
fragment
PLUS
	:	'+'
	;


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
EXPONENT : ('e'|'E') (PLUS|'-')? ('0'..'9')+ ;

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

