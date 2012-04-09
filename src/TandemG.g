grammar TandemG;

options {
  language = Java;
  output = AST;
  ASTLabelType = CommonTree;
}

S	:	I M | M;
I	:	(Imp NEWLINE)+;
		
Imp	:	From F Import Modules | Import F;
F	:	Filename;
Modules	:	'*'| (Identifier ('.'Identifier)* )+;
		
M	:	Body|/*epsilon*/;
Body	:	Statement (NEWLINE Statement)*;
		
Statement	:	'node' Identifier '(' Params ')' NEWLINE M NEWLINE 'end'| Expression
		| Assignment| LoopType | 'return' Expression
		| 'assert' Expression;
Params	:	ParamList|/*epsilon*/;
ParamList	:	Identifier| Identifier ',' ParamList;
Assignment	:	IndexAssign '='Expression| IndexAssign '+=' Expression
		| IndexAssign '-='Expression| IndexAssign '*='Expression
		| IndexAssign '/='Expression| IndexAssign '%='Expression
		| IndexAssign '**='Expression| IndexAssign '>>='Expression
		| IndexAssign '<<='Expression| IndexAssign '^='Expression
		| IndexAssign '/\\='Expression| IndexAssign '\\/='Expression
		| IndexAssign '&&='Expression| IndexAssign '||='Expression;
IndexAssign	:	Indexed| Identifier;
LoopType	:	'for' Identifier 'in' Iterable NEWLINE LM NEWLINE 'end'| 'while' Expression NEWLINE LM NEWLINE 'end'
		| 'do' NEWLINE LM NEWLINE 'while' Expression NEWLINE 'end'| 'loop' NEWLINE LM NEWLINE 'end'
		| 'until' Expression NEWLINE LM NEWLINE 'end';
Iterable	:	List| Set| Hash| String| Range;
CondType	:	'if' Expression NEWLINE M NEWLINE 'else' NEWLINE M NEWLINE 'end'| 'unless' Expression NEWLINE M NEWLINE 'end'
		| 'cond' NEWLINE CBody NEWLINE 'end'| 'fork' NEWLINE CBody NEWLINE 'end';
CBody	:	Cstatements|/*epsilon*/;
Cstatements	:	Csentence| Csentence NEWLINE Cstatements;
Csentence	:	Expression NEWLINE M NEWLINE 'end';
LM	:	Lbody|/*epsilon*/;
Lbody	:	Lstatement NEWLINE Lbody| Lstatement;
Lstatement	:	'node' Identifier '(' Params ')' NEWLINE M NEWLINE 'end'| Expression| Assignment
		| 'return' Expression| LoopType| 'assert' Expression| Break| 'continue';
Break	:	'break'| 'break' Expression;
		
Expression	:	(ID | CondType | Unary Expression | Literal | Indexed | Attr | '(' Expression ')') ((Binop Expression)*)*;
ID	:	Identifier| Identifier NParams| Identifier Pipeline| Identifier NParams Pipeline;
NParams	:	(Literal | Identifier)+;


Pipeline	:	'|' Identifier| '|' Identifier Pipeline;
		
Unary	:	'+'|'-'|'~'|'!'| 'not';
Binop	:	MathOp| BitwiseOp| RelOp| LogicOp;
MathOp	:	'+'|'-'|'*'|'/'|'%'|'mod'|'**';
BitwiseOp	:	'<<'|'>>'|'/\\'|'\\/'|'~'|'^';
RelOp	:	'<'|'<='|'>='|'>';
LogicOp	:	'&&'|'||'| 'is'| 'is not'| 'in'| 'not in'|'=='|'!='
		| 'and'| 'xor'| 'or';
Literal	:	AlphaNum| List| Hash| Set| Range| 'true'| 'false'| 'null'| 'none';
Indexed	:	Identifier Indexer| Hash Indexer| List Indexer;
Indexer	:	'[' Key ']'|'[' Key ']' Indexer;
Attr	:	Identifier '.' Attributes;
Attributes	:	Identifier| Identifier '.' Attributes;
List	:	'[' Innards ']';
Set	:	'{' Literal '}';
Innards	:	Literal (',' (Literal | Identifier ))*| Identifier (',' (Literal | Identifier ))*;
Hash	:	'{' Hinnards '}';
Hinnards	:	(Key '=>' Key) (',' Key '=>' Key)*;
Key	:	Identifier| Literal;
AlphaNum	:	Numeric| String| ByteLiteral| HexLiteral;
Range	:	Numeric RangeTail;
RangeTail	:	'..' Numeric;

//Lex Shtuff
Numeric: Int | Float;
Int : Digit+;
Digit: '0'..'9';
Float: Digit + ('.' Digit +)?;
From: 'from';
Import: 'import';
Filename:('a'..'z' |'A'..'Z' |'_' ) ('a'..'z' |'A'..'Z' |'_' |'0'..'9' )*'.td';
ByteLiteral: '0b'('0' | '1')+;
HexLiteral: '0x' (Digit | 'A'..'F' | 'a'..'f' )+;
String: '\"' .* '\"' | '\'' .* '\'';
Identifier : ('a'..'z' |'A'..'Z' |'_' ) ('a'..'z' |'A'..'Z' |'_' |'0'..'9' )* ;
NEWLINE:('\r' ? '\n')  | ';';
WS: (' ' |'\t' |'\n' |'\r' | ';' )+ {skip();} ;


