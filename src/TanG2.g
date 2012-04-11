grammar TanG2;

options{
language=Java;
output=AST;
ASTLabelType=CommonTree;
backtrack=true;
memoize=true;
}

tanG	:	i* m;

//Import Statemnts
i	:	from ID tandemextension imp (ID ('.' ID)* | '*') NEWLINE
	|	imp ID tandemextension NEWLINE;

//Main body
m	:	(statement NEWLINE)*;

statement
	:	node ID '('! params ')'! NEWLINE m NEWLINE end
	|	expression
	|	loopType
	|	return expression
	|	assert expression
	|	break (expression)?
	|	continue;
	
params	:	ID(',' ID)*;

//Loops
loopType	:	for ID in iterable NEWLINE m end
	|	while expression NEWLINE m end
	|	do NEWLINE m while expression NEWLINE end
	|	loop NEWLINE m end
	|	until expression NEWLINE m end;
//Things that can be iterated through
iterable	:	ID;

//Expressions
expression
	:	condType| orExpression;

//conditionals
condType	:	if expression NEWLINE m else NEWLINE m end
	|	unless expression NEWLINE m end
	|	cond  (cstatement NEWLINE)* end;
	
cstatement
	:	expression NEWLINE m end;
	
//ExpressionTypes
orExpression
	:	xorExpr (OR xorExpr)*;
	
xorExpr	:	andExpr (XOR andExpr)*;

andExpr	:	notExpr (AND notExpr)*;

notExpr	:	(NOT)? memExpr;

memExpr	:	idTestExpr (MEMTEST idTestExpr)?;

idTestExpr
	:	modExpr (IDTEST modExpr)?;
	
modExpr	:	assignment (MOD assignment)*;

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
	:	ID;

//Keywords
from	:	'from';
imp	:	'import';
tandemextension
	:	'.td'
	;
node	:	'node';
end	:	'end';
return	:	'return';
assert	:	'assert';
break	:	'break';
continue	:	'continue';
for	:	'for';
in	:	'in';
while	:	'while';
do	:	'do';
loop	:	'loop';
until	:	'until';
if	:	'if';
else	:	'else';
unless	:	'unless';
cond	:	'cond';
fork	:	'fork';

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

//IDs
fragment
ID  :	('a'..'z'|'A'..'Z'|'_') ('a'..'z'|'A'..'Z'|'0'..'9'|'_')*
    ;


NEWLINE	:	'\r'? '\n'
		;