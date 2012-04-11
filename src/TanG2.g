grammar TanG2;

options{
language=Java;
output=AST;
ASTLabelType=CommonTree;
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
	|	assert expression;
	
params	:	ID(',' ID)*;

//Loops
loopType:	'dishereisaloop';

//Expressions
expression
	:	'this is an expression';


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
for	:	'for';
in	:	'in';
while	:	'while';
do	:	'do';
loop	:	'loop';
until	:	'until';

//Lexer/Tokens
fragment
ID  :	('a'..'z'|'A'..'Z'|'_') ('a'..'z'|'A'..'Z'|'0'..'9'|'_')*
    ;
    
fragment
NEWLINE	:	'\r'? '\n'
		;