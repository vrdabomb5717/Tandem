grammar WateredDownTanG;

options{
language=Java;
output=AST;
ASTLabelType=CommonTree;
}

tanG	:	NEWLINE? ((i ((NEWLINE  EOF)?|(NEWLINE m (NEWLINE EOF)?)))? | m);

//Import Statements
i	:	td_from filename td_imp (    ID      (DOT ID)*    (   COMMA  ID (DOT ID)*      )*    | '*'       ) (NEWLINE iprime)? 
 	|	td_imp filename (NEWLINE iprime)?; 
 	
 iprime	:	td_from filename td_imp (ID (DOT ID)* (COMMA  ID (DOT ID)*)* | '*') (NEWLINE i)?
 	|	td_imp filename (NEWLINE i)?;

//Main body
m	:	statement (NEWLINE mprime)?;

mprime	:	statement (NEWLINE m)?;

statement
	:	td_node ID LPAREN! params RPAREN! NEWLINE (m NEWLINE)? td_end
	|	expression
	|	loopType
	|	td_return orExpression
	|	td_assert orExpression
	|	td_break (orExpression)?
	|	td_continue;
	
params	:	(ID(COMMA ID)*)?;

//Loops
loopType	:	td_for ID td_in iterable NEWLINE (m NEWLINE)? td_end
	|	td_while orExpression NEWLINE (m NEWLINE) td_end
	|	td_loop NEWLINE (m NEWLINE) td_end
	|	td_until orExpression NEWLINE (m NEWLINE)? td_end;
//Things that can be iterated through
iterable	:	ID;

//Expressions
expression
	:	condType | orExpression;

//conditionals
condType	:	td_if orExpression NEWLINE (m NEWLINE)? td_else NEWLINE (m NEWLINE)? td_end
	|	td_unless orExpression NEWLINE (m NEWLINE)? td_end
	|	td_cond  NEWLINE (cstatement NEWLINE)* td_end;
	
cstatement
	:	orExpression NEWLINE (m NEWLINE)? td_end;
	
//ExpressionTypes
orExpression
	:	xorExpr (td_or xorExpr)*;
	
xorExpr	:	andExpr (td_xor andExpr)*;

andExpr	:	notExpr (td_and notExpr)*;

notExpr	:	(td_not)*  memExpr;

memExpr	:	idTestExpr (td_memtest idTestExpr)?;

idTestExpr
	:	modExpr (td_idtest modExpr)*;
	
	
modExpr	:	assignment (td_mod assignment)*;

assignment
	:	rangeExpr (ASSN assignment)?;
	
rangeExpr
	:	boolOrExpr (RANGE boolOrExpr)?|INTRANGE;
	
boolOrExpr
	:	boolAndExpr (BOOLOR boolAndExpr)*;

boolAndExpr
	:	eqTestExpr (BOOLAND eqTestExpr)*;
	
eqTestExpr
	:	magCompExpr (EQTEST eqTestExpr)?;
	
magCompExpr
	:	bitOrExpr (MAGCOMP magCompExpr)?;
	
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
	
multExpr:		indexable (MULT indexable)*;	










	
indexable
	:	attributable (LBRACK attributable RBRACK)*;

attributable
	:	atom (DOT atom)*;
	
	
//atom
atom	:	ID|INT|FLOAT|HEX|BYTE|STRING| LPAREN orExpression RPAREN|list|hashSet|td_truefalse;

list	:	LBRACK (orExpression (COMMA orExpression)*)? RBRACK;

hashSet	:	LBRACE (orExpression (hashInsides|setInsides))? RBRACE;
hashInsides
	:	FATCOMMA orExpression (COMMA orExpression FATCOMMA orExpression)*;
setInsides
	:	(COMMA orExpression)*;//orExpression (COMMA orExpression)*;

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
	:	NOT? IN;
td_idtest
	:	IS (NOT)?;
td_mod	:	MOD;
td_truefalse
	:	TF;
//Lexer/Tokens

//Operators  
COMMENT
    :   ('#' |'//') ~('\n'|'\r')* '\r'? '\n' {skip();}
    |   '/*' ( options {greedy=false;} : . )* '*/' (NEWLINE)? {skip();}
    ;
  
FROM
	:	'from'
	;
FILENAME	:	(('"')('a'..'z'|'A'..'Z'|'_') ('a'..'z'|'A'..'Z'|'0'..'9'|'_')* '.td' ('"'))
	|	(('\'')('a'..'z'|'A'..'Z'|'_') ('a'..'z'|'A'..'Z'|'0'..'9'|'_')* '.td' ('\''));
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
IS	:	'is';
MOD	:	'mod';
TF	:	'true'|'false';
INTRANGE	:	('0'..'9')+'..'('0'..'9')+;
RANGE	:	'..';
EQTEST	:	'=='|'!=';
ASSN	:	'='|'+='|'-='|'*='|'/='|'%='|'**='|'>>='|'<<='|'^='
	|	'/\\='|'\\/='|'&&='|'||=';
BOOLOR	:	'||';
BOOLAND	:	'&&';
MAGCOMP	:	'>'|'<'|'>='|'<=';
BITOR	:	'\\/';
BITXOR	:	'^';
BITAND	:	'/\\';
BITSHIFT	:	'>>'|'<<';
ADDSUB	:	'+'|'-';
EXP	:	'**';
MULT	:	'*'|'/'|'%';
BITNOT	:	'!';
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
FLOAT
    :   ('0'..'9')+ DOT ('0'..'9')+ EXPONENT?
    |   DOT ('0'..'9')+ EXPONENT?
    |   ('0'..'9')+ EXPONENT
    ;


INT :	'0'..'9'+
    ;

NEWLINE	:	('\r'? '\n')+
		;


WS  :   ( ' '
        | '\t'
        ) {skip();};



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
    


