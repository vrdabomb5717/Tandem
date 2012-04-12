grammar TanG2;

options{
language=Java;
output=AST;
ASTLabelType=CommonTree;
backtrack=true;
memoize=true;
}

tanG	:	i* m;

//Import Statements
i	:	td_from ID td_tandemextension td_imp (ID ('.' ID)* | '*') NEWLINE
 	|	td_imp ID td_tandemextension NEWLINE;

//Main body
m	:	(statement NEWLINE)*;

statement
	:	td_node ID '('! params ')'! NEWLINE m NEWLINE td_end
	|	expression
	|	loopType
	|	td_return expression
	|	td_assert expression
	|	td_break (expression)?
	|	td_continue;
	
params	:	ID(',' ID)*;

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
	:	attributeExpr ('['! attributeExpr ']'!)*;
	
attributeExpr
	:	atom ('.' ID)*;
	
atom	:	ID| '('!expression')'!|INT|FLOAT|STRING|HEX|BYTE|hash|set|list;

hash	:	'{' (atom FATCOMMA atom (',' atom FATCOMMA atom)*)? '}';
set	:	'{'(atom (',' atom)*)?'}';
list	:	'['(atom (',' atom)*)?']';


//Keywords
td_from	:	'from';
td_imp 	:	'import';
td_tandemextension
           	:	'.td'
           	;
td_node    	:	'node';
td_end     	:	'end';
td_return  	:	'return';
td_assert  	:	'assert';
td_break   	:	'break';
td_continue	:	'continue';
td_for     	:	'for';
td_in      	:	'in';
td_while   	:	'while';
td_do      	:	'do';
td_loop    	:	'loop';
td_until   	:	'until';
td_if      	:	'if';
td_else    	:	'else';
td_unless  	:	'unless';
td_cond    	:	'cond';
td_fork    	:	'fork';
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
MULT	:	'*'|'/'|'%';
fragment
BITNOT	:	'!';
fragment
EXP	:	'**';
fragment
PIPE	:	'|';
fragment
FATCOMMA	:	'=>';

//other stuff
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
