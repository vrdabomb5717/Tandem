grammar TanG;

options{
language=Java;
output=AST;
ASTLabelType=CommonTree;
backtrack=true;
memoize=true;
}

tanG	:	i* m;

//Import Statements
i	:	td_from ID filename td_imp (ID (DOT ID)* | ALLTHETHINGS) NEWLINE
 	|	td_imp ID filename NEWLINE;

//Main body
m	:	(statement NEWLINE)*;

statement
	:	td_node ID LPAREN! params RPAREN! NEWLINE m NEWLINE td_end
	|	expression
	|	loopType
	|	td_return expression
	|	td_assert expression
	|	td_break (expression)?
	|	td_continue;
	
params	:	ID(COMMA ID)*;

//Loops
loopType	:	td_for ID td_in iterable NEWLINE m td_end
	|	td_while expression NEWLINE m td_end
	|	td_do NEWLINE m td_while expression NEWLINE td_end
	|	td_loop NEWLINE m td_end
	|	td_until expression NEWLINE m td_end;
//Things that can be iterated through
iterable	:	ID;

//Expressions
expression
	:	condType| orExpression;

//conditionals
condType	:	td_if expression NEWLINE m td_else NEWLINE m td_end
	|	td_unless expression NEWLINE m td_end
	|	td_cond  (cstatement NEWLINE)* td_end;
	
cstatement
	:	expression NEWLINE m td_end;
	
//ExpressionTypes
orExpression
	:	xorExpr (td_or xorExpr)*;
	
xorExpr	:	andExpr (td_xor andExpr)*;

andExpr	:	notExpr (td_and notExpr)*;

notExpr	:	(td_not)? memExpr;

memExpr	:	idTestExpr (td_memtest idTestExpr)?;

idTestExpr
	:	modExpr (td_idtest modExpr)?;
	
modExpr	:	assignment (td_mod assignment)*;

assignment
	:	(rangeExpr ASSN)* rangeExpr;
	
rangeExpr	:	nRangeExpr (RANGE nRangeExpr)?;

nRangeExpr
	:	boolAndExpr (NRANGE boolAndExpr)*;

boolAndExpr
	:	eqTestExpr (BOOLAND eqTestExpr)*;
	
eqTestExpr
	:	magCompExpr (EQTEST magCompExpr)?;
	
magCompExpr
	:	bitOrExpr (MAGCOMP bitOrExpr)*;
	
bitOrExpr
	:	bitXorExpr (BITOR bitXorExpr)*;
	
bitXorExpr
	:	bitAndExpr (BITXOR bitAndExpr)*;
	
bitAndExpr
	:	bitShiftExpr (BITAND bitShiftExpr)*;
	
bitShiftExpr
	:	addSubExpr (BITSHIFT addSubExpr)*;
	
addSubExpr
	:	multExpr (ADDSUB multExpr)*;
	
multExpr	:	unariesExpr (MULT unariesExpr)*;

unariesExpr
	:	(ADDSUB)* bitNotExpr;
	
bitNotExpr
	:	(BITNOT)* expExpression;
	
expExpression
	:	(pipelineExpr EXP)* pipelineExpr;
	
pipelineExpr
	:	indexable (indexable)* (PIPE indexable)*;
	
indexable
	:	attributeExpr (LBRACK! attributeExpr RBRACK!)*;
	
attributeExpr
	:	atom (DOT ID)*;
	
atom	:	ID| LPAREN!expression RPAREN!|INT|FLOAT|STRING|HEX|BYTE|hash|set|list;

hash	:	LEFTBRACE (atom FATCOMMA atom (COMMA atom FATCOMMA atom)*)? '}';
set	:	LEFTBRACE(atom (COMMA atom)*)? LBRACE;
list	:	LBRACK(atom (COMMA atom)*)?RBRACK;


//Keywords
td_from	:	FROM;
td_imp 	:	IMPORT
           	;
filename	:	FILENAME;
td_node    	:	NODE;
td_end     	:	END;
td_return  	:	RETURN;
td_assert  	:	ASSERT;
td_break   	:	BREAK;
td_continue	:	CONTINUE;
td_for     	:	FOR;
td_in      	:	IN;
td_while   	:	WHILE;
td_do      	:	DO;
td_loop    	:	LOOP;
td_until   	:	UNTIL;
td_if      	:	IF;
td_else    	:	ELSE;
td_unless  	:	UNLESS;
td_cond    	:	COND;
td_fork    	:	FORK;
td_or	:	OR;
td_xor	:	XOR;
td_and	:	AND;
td_not	:	NOT;
td_memtest
	:	MEMTEST;
td_idtest
	:	IDTEST;
td_mod	:	MOD;

//Lexer/Tokens

//Operators
fragment    
FROM
	:	'from'
	;
fragment
FILENAME	:	ID '.td';
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
ASSERT	:	'assert';
fragment
CONTINUE	:	'continue';
fragment
BREAK	:	'break';
fragment
FOR	:	'for';
fragment
IN	:	'in';
fragment
WHILE	:	'while';
fragment
DO	:	'do';
fragment
LOOP	:	'loop';
fragment
IF	:	'if';
fragment
ELSE	:	'else';
fragment
UNTIL	:	'until';
fragment
UNLESS	:	'unless';
fragment
COND	:	'cond';
fragment
FORK	:	'fork';
fragment
OR	:	'or';
fragment
XOR	:	'xor';
fragment
AND	:	'and';
fragment
NOT	:	'not';
fragment
MEMTEST	:	'in' | 'not in';
fragment
IDTEST	:	'is'| 'is not';
fragment
MOD	:	'mod';
fragment
ASSN	:	'='|'+='|'-='|'*='|'/='|'%='|'**='|'>>='|'<<='|'^='
	|	'/\\='|'\\/='|'&&='|'||=';
fragment
RANGE	:	'..';
fragment
NRANGE	:	'||';
fragment
BOOLAND	:	'&&';
fragment
EQTEST	:	'=='|'!=';
fragment
MAGCOMP	:	'>'|'<'|'>='|'<=';
fragment
BITOR	:	'\\/';
fragment
BITXOR	:	'^';
fragment
BITAND	:	'/\\';
fragment
BITSHIFT	:	'>>'|'<<';
fragment
ADDSUB	:	'+'|'-';
fragment
MULT	:	ALLTHETHINGS|'/'|'%';
fragment
BITNOT	:	'!';
fragment
EXP	:	'**';
fragment
PIPE	:	'|';
fragment
FATCOMMA	:	'=>';
fragment
DOT
	:	'.'
	;
fragment
ALLTHETHINGS
	:	'*'
	;
fragment
LPAREN
	:	'('
	;
fragment
COMMA
	:	','
	;	
fragment
RPAREN
	:	')'
	;
	
fragment
LBRACK
	:	'['
	;
fragment
LEFTBRACE
	:	'{'
	;
fragment
RBRACK	:	']';

fragment
LBRACE	:	'{';

//other stuff
fragment
INT :	'0'..'9'+
    ;
    
fragment
FLOAT
    :   ('0'..'9')+ DOT ('0'..'9')* EXPONENT?
    |   DOT ('0'..'9')+ EXPONENT?
    |   ('0'..'9')+ EXPONENT
    ;

COMMENT
    :   '//' ~('\n'|'\r')* '\r'? '\n' {$channel=HIDDEN;}
    |   '/*' ( options {greedy=false;} : . )* '*/' {$channel=HIDDEN;}
    ;

NEWLINE	:	'\r'? '\n'
		;

WS  :   ( ' '
        | '\t'
        | '\r'
        | '\n'
        ) {$channel=HIDDEN;}
    ;
    
fragment
HEX	:	'0x' (HEX_DIGIT)+;

fragment
BYTE	:	'0b' ('1'|'0')+;

fragment
STRING
    :  '"' ( ESC_SEQ | ~('\\'|'"') )* '"'
    ;

fragment
EXPONENT : ('e'|'E') (ADDSUB)? ('0'..'9')+ ;

fragment
HEX_DIGIT : ('0'..'9'|'a'..'f'|'A'..'F') ;

fragment
ESC_SEQ
    :   '\\' ('b'|'t'|'n'|'f'|'r'|'\"'|'\''|'\\');
    
fragment
ID  :	('a'..'z'|'A'..'Z'|'_') ('a'..'z'|'A'..'Z'|'0'..'9'|'_')*
    ;



