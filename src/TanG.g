//TanG Grammar  Patrick De La Garza - Language Guru
 
 
grammar TanG;

options{
language=Java;
output=AST;
ASTLabelType=CommonTree;
}

@lexer::members{
 public List<String> errors = new ArrayList<String>();
}



//Start: rewritten so that start Token is not null
tanG	:	prog ->^(ROOTNODE["@@"] prog?);

//Describes the program layout
prog	:	(NEWLINE* ((i ((NEWLINE+  EOF)?|(NEWLINE+ m (NEWLINE+ EOF)?)))? | (m)));

//Import Statements
i	:	((td_imp^ filename)|td_require^ STRING) (NEWLINE+ iprime)?; 
 	
 iprime	:	((td_imp^ filename)|td_require^ STRING) (NEWLINE+ i)?;

//Main body: this is composed of any number of valid statements
m	:	(statementNL (NEWLINE+ statementNL)*)->^(MAIN["@"] statementNL+);

//This production is used to rewrite statements so that we minimize changes to the original code generator
statementNL
	:	statement->statement NEWLINE["\n"];

//This is the list of valid statement types, starting with a node definition
statement
	:	td_node^ NODEID LPAREN params RPAREN NEWLINE+ (m NEWLINE+)? td_end
	|	expression
	|	loopType
	|	td_return orExpression
	|	td_assert orExpression
	|	td_break (orExpression)?
	|	td_continue;

//valid node parameters
params	:	(ID(COMMA ID)*)?;

//All of the loop types
loopType	:	td_for ID td_in iterable NEWLINE+ (m NEWLINE+)? td_end
	|	td_while orExpression NEWLINE+ (m NEWLINE+) td_end
	|	td_loop NEWLINE+ (m NEWLINE+) td_end
	|	td_until orExpression NEWLINE+ (m NEWLINE+)? td_end;

//Things that can be iterated through
iterable	:	rangeExpr;

//Expressions, these consist of condition statements and expressions
expression
	:	condType | orExpression;

//conditionals
condType	:	td_if orExpression NEWLINE+ (m NEWLINE+)? td_else NEWLINE+ (m NEWLINE+)? td_end
	|	td_unless orExpression NEWLINE+ (m NEWLINE+)? td_end
	|	td_cond^  NEWLINE+ (cstatement NEWLINE+)* td_end;

//Cases for cond statements
cstatement
	:	orExpression^ NEWLINE+ (m NEWLINE+)? td_end;

//ExpressionTypes
orExpression
	:	xorExpr (td_or^ xorExpr)*;

xorExpr	:	andExpr (td_xor^ andExpr)*;

andExpr	:	notExpr (td_and^ notExpr)*;

notExpr	:	(td_not^)*  memExpr;

memExpr	:	idTestExpr (td_memtest^ idTestExpr)?;

idTestExpr
	:	modExpr (td_idtest^ modExpr)?;


modExpr	:	assignment (td_mod^ assignment)*;

assignment
	:	assignable (ASSN^ assignment)|rangeExpr;
	
assignable
	:	(assnAttr^ (LBRACK assnAttr RBRACK)*);
	
assnAttr:	(ID (DOT^ ID)*);

rangeExpr
	:	boolOrExpr (RANGE^ boolOrExpr)?;

boolOrExpr
	:	boolAndExpr (BOOLOR^ boolAndExpr)*;

boolAndExpr
	:	eqTestExpr (BOOLAND^ eqTestExpr)*;

eqTestExpr
	:	magCompExpr (EQTEST^ magCompExpr)?;

magCompExpr
	:	bitOrExpr (MAGCOMP^ bitOrExpr)?;

bitOrExpr
	:	bitXorExpr (BITOR^ bitXorExpr)*;

bitXorExpr
	:	bitAndExpr (BITXOR^ bitAndExpr)*;

bitAndExpr
	:	bitShiftExpr (BITAND^ bitShiftExpr)*;

bitShiftExpr
	:	addSubExpr (BITSHIFT^ addSubExpr)*;

addSubExpr
	:	multExpr (ADDSUB^ multExpr)*;

multExpr:	unariesExpr ((MULT^| STAR^) unariesExpr)*;	


unariesExpr
	:	(ADDSUB^)* bitNotExpr;

bitNotExpr
	:	(BITNOT^)* expExpression;
expExpression
	:	pipelineExpr (EXP^ expExpression)?;
	

pipelineExpr
	:	atom|((pipestart (indexable)* (pipe^ pipenode)*))
	;
	

pipe	:	PIPE;

pipestart
	:	attrStart^ (LBRACK (pipestart|pipeatom2) RBRACK)*;//(ID|NODEID) (DOT^ (NODEID|ID|FUNCID))*;

pipenode
	:	((NODEID) (DOT^ (NODEID|ID|FUNCID))*)|(ID (DOT^ ID)+);
	

indexable
	:	(nonAtomAttr^ (LBRACK indexable RBRACK)+)|pipeattributable;
	
attrStart
	:	(ID|NODEID) (DOT^ ID)*;
	
nonAtomAttr
	:	ID (DOT^ ID)*;


pipeattributable
	:	(ID (DOT^ ID)+)|pipeatom;	

//atom
atom	:	INT|FLOAT|HEX|BYTE|STRING| LPAREN! orExpression RPAREN!|list|hashSet|td_truefalse|td_none|td_null|td_some|filename;
pipeatom:	ID|INT|FLOAT|HEX|BYTE|STRING| LPAREN! orExpression RPAREN!|hashSet|td_truefalse|td_none|td_null|td_some|filename;
pipeatom2
	:	INT|FLOAT|HEX|BYTE|STRING| LPAREN! orExpression RPAREN!|hashSet|td_truefalse|td_none|td_null|td_some|filename;


list	:	LBRACK (orExpression (COMMA orExpression)*)? RBRACK;

hashSet	:	LBRACE (orExpression (hashInsides))? RBRACE;
hashInsides
	:	FATCOMMA orExpression (COMMA orExpression FATCOMMA orExpression)*;


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
td_none	:	NONE;
td_null	:	NULL;
td_some	:	SOME;
td_require
	:	REQUIRE;
	
//Lexer/Tokens

//Operators
ROOTNODE:	'@@';
MAIN	:	'@';
PIPEROOT:	'$';
FUNCID	:	('a'..'z'|'A'..'Z') ('a'..'z'|'A'..'Z'|'0'..'9'|'_')*'?';  
COMMENT
    :   ('#' |'//') ~('\n'|'\r')*   {skip();}
;

FROM
	:	'from'
	;
FILENAME	:	(('"')('a'..'z'|'A'..'Z'|'_') ('a'..'z'|'A'..'Z'|'0'..'9'|'_')* '.td' ('"'))
	|	(('\'')('a'..'z'|'A'..'Z'|'_') ('a'..'z'|'A'..'Z'|'0'..'9'|'_')* '.td' ('\''));
IMPORT
	:	'import'
	;
REQUIRE	:	'require';
NODE
	:	'node'|'public node'
	;
TOKEN	:	'private';
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
NULL	:	'null';
SOME	:	'some';
NONE	:	'none';
WITH	:	'with';
TRY	:	'try';
CATCH	:	'catch';
FINALLY	:	'finally';
RANGE	:	'..';
FATCOMMA	
	:	'=>';
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
STAR	:	'*';
MULT	:	'/'|'%';
BITNOT	:	'!'|'~';
PIPE	:	'|';
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
    :   ('0'..'9')+   (
        {input.LA(2) != '.'}? => ('.' ('0'..'9')+ EXPONENT? {$type = FLOAT;})
        |({$type = INT;})
        
    )
    |   ('0'..'9')+ EXPONENT
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

PUBPRIV	:	'public'|'private';

NODEID	:	('A'..'Z')('a'..'z'|'A'..'Z'|'0'..'9'|'_')*;

ID  :	('a'..'z'|'_') ('a'..'z'|'A'..'Z'|'0'..'9'|'_')*
    ;



fragment
HEX_DIGIT : ('0'..'9'|'a'..'f'|'A'..'F') ;

fragment
ESC_SEQ
    :   '\\' ('b'|'t'|'n'|'f'|'r'|'\"'|'\''|'\\');


    
INVALID
 :  . {
        errors.add("Invalid character: '" + $text + "' on line: " +
            getLine() + ", index: " + getCharPositionInLine()); }; 
