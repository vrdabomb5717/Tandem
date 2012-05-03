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

pipelineExpr
	:	indexable (pipeparamindexable)*  (PIPE^ indexable)* -> ^(indexable (^PIPE indexable)* (pipeparamindexable)*);


