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
i	:	td_from filename td_imp (ID (DOT ID)* | '*') NEWLINE
 	|	td_imp filename NEWLINE;

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

hash	:	LBRACE (atom FATCOMMA atom (COMMA atom FATCOMMA atom)*)? '}';
set	:	LBRACE(atom (COMMA atom)*)? RBRACE;
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
FROM
	:	'from'
	;
FILENAME	:	 ('a'..'z'|'A'..'Z'|'_') ('a'..'z'|'A'..'Z'|'0'..'9'|'_')* '.td';
IMPORT
	:	'import'
	;
NODE
	:	'node'
	;
END
	:	'end'
	;
RETURN
	:	'return'
	;
ASSERT	:	'assert';
CONTINUE	:	'continue';
BREAK	:	'break';
FOR	:	'for';
IN	:	'in';
WHILE	:	'while';
DO	:	'do';
LOOP	:	'loop';
IF	:	'if';
ELSE	:	'else';
UNTIL	:	'until';
UNLESS	:	'unless';
COND	:	'cond';
FORK	:	'fork';
OR	:	'or';
XOR	:	'xor';
AND	:	'and';
NOT	:	'not';
MEMTEST	:	'in' | 'not in';
IDTEST	:	'is'| 'is not';
MOD	:	'mod';
ASSN	:	'='|'+='|'-='|'*='|'/='|'%='|'**='|'>>='|'<<='|'^='
	|	'/\\='|'\\/='|'&&='|'||=';
RANGE	:	'..';
NRANGE	:	'||';
BOOLAND	:	'&&';
EQTEST	:	'=='|'!=';
MAGCOMP	:	'>'|'<'|'>='|'<=';
BITOR	:	'\\/';
BITXOR	:	'^';
BITAND	:	'/\\';
BITSHIFT	:	'>>'|'<<';
ADDSUB	:	'+'|'-';
MULT	:	'*'|'/'|'%';
BITNOT	:	'!';
EXP	:	'**';
PIPE	:	'|';
FATCOMMA	:	'=>';
DOT
	:	'.'
	;
LPAREN
	:	'('
	;
COMMA
	:	','
	;	
RPAREN
	:	')'
	;
	
LBRACK	:	'[';
RBRACK	:	']';

LBRACE	:	'{';

RBRACE	:	'}';

//other stuff
INT :	'0'..'9'+
    ;
    
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
        )+ {skip();}
    ;
    
HEX	:	'0x' (HEX_DIGIT)+;

BYTE	:	'0b' ('1'|'0')+;

STRING
    :  '"' ( ESC_SEQ | ~('\\'|'"') )* '"'
    ;

EXPONENT : ('e'|'E') ('+'|'-')? ('0'..'9')+ ;

ID  :	('a'..'z'|'A'..'Z'|'_') ('a'..'z'|'A'..'Z'|'0'..'9'|'_')*
    ;


fragment
HEX_DIGIT : ('0'..'9'|'a'..'f'|'A'..'F') ;

fragment
ESC_SEQ
    :   '\\' ('b'|'t'|'n'|'f'|'r'|'\"'|'\''|'\\');
    


