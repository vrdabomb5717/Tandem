//Tree Grammar for TanG
//Transformations

//magcompExpr
//eqtestExpr
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


magCompExpr
	:	bitOrExpr (MAGCOMP^ magCompExpr)?;


eqTestExpr
	:	magCompExpr (EQTEST^ eqTestExpr)?;


pipelineExpr
	:	indexable (pipeparamindexable)*  (PIPE^ indexable)*;

