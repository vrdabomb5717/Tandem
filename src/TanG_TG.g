//Tree Grammar for TanG
//Transformations

//pipelineExpr


tree grammar TanG_TG;

options
{
	language=Java;
	output=AST;
	ASTLabelType=CommonTree;
	tokenVocab=TanG;
 	rewrite=true;
}


	

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
	:	rangeExpr (ASSN^ assignment)?;
	
rangeExpr
	:	boolOrExpr (RANGE^ boolOrExpr)?|INTRANGE^;
	
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
	
multExpr:		unariesExpr ((MULT^| STAR^) unariesExpr)*;	


unariesExpr
	:	(ADDSUB^)* bitNotExpr;
	
bitNotExpr
	:	(BITNOT^)* expExpression;
expExpression
	:	pipelineExpr (EXP^ expExpression)?;
	



pipelineExpr
	:	indexable (PIPE^ pipelineExpr)? pipeparamindexable*;
			
	
indexable
	:	attributable^ (LBRACK attributable RBRACK)*;

pipeparamindexable
	:	pipeparamattributable (LBRACK pipeparamattributable RBRACK)*;

attributable
	:	atom (DOT^ atom)*;
	
pipeparamattributable
	:	pipeparamatom (DOT^ pipeparamatom)*;
	
	
//atom
atom	:	ID|INT|FLOAT|HEX|BYTE|STRING| LPAREN! orExpression RPAREN!|list|hashSet|td_truefalse|td_none|td_null|td_some;

pipeparamatom
	:	ID|INT|FLOAT|HEX|BYTE|STRING| LPAREN! orExpression RPAREN!|td_truefalse|td_null|td_some|td_none;

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
td_none	:	NONE;
td_null	:	NULL;
td_some	:	SOME;



