import org.antlr.runtime.ANTLRStringStream;
import org.antlr.runtime.CommonTokenStream;
import org.antlr.runtime.RecognitionException;
import org.antlr.runtime.TokenStream;
import org.antlr.runtime.tree.CommonTree;
import java.io.*;
import org.antlr.runtime.*;

public class TreeWalker {	
	public void printTree(CommonTree t) {
		if ( t != null ) {			
			for ( int i = 0; i < t.getChildCount(); i++ ) {
				switch(t.getType()){
				//TODO: Add Code
					case TanGParser.ADDSUB:	
						//print out ruby code to a file
						break;
					case TanGParser.AND:
						break;
					case TanGParser.ASSN:
						break;
					case TanGParser.BITAND:
						break;
					case TanGParser.BITNOT:
						break;
					case TanGParser.BITOR:
						break;
					case TanGParser.BITSHIFT:
						break;					
					case TanGParser.BITXOR:
						break;
					case TanGParser.BOOLAND:
						break;
					case TanGParser.BYTE:
						break;
					case TanGParser.COMMENT:
						break;
					case TanGParser.EOF:
						break;
					case TanGParser.EQTEST:
						break;
					case TanGParser.ESC_SEQ:
						break;
					case TanGParser.EXP:
						break;
					case TanGParser.EXPONENT:
						break;
					case TanGParser.FATCOMMA:
						break;
					case TanGParser.FLOAT:
						break;
					case TanGParser.HEX:
						break;
					case TanGParser.HEX_DIGIT:
						break;
					case TanGParser.ID:
						break;
					case TanGParser.IDTEST:
						break;
					case TanGParser.INT:
						break;
					case TanGParser.MAGCOMP:
						break;
					case TanGParser.MEMTEST:
						break;
					case TanGParser.MOD:
						break;
					case TanGParser.MULT:
						break;
					case TanGParser.NEWLINE:
						break;
					case TanGParser.NOT:
						break;
					case TanGParser.NRANGE:
						break;
					case TanGParser.OR:
						break;
					case TanGParser.PIPE:
						break;
					case TanGParser.RANGE:
						break;
					case TanGParser.STRING:
						break;
					case TanGParser.WS:
						break;
					case TanGParser.XOR:
						break;	
					//TODO: T_ cases
				}
				printTree((CommonTree)t.getChild(i));
			}
		}
	}
}
