import org.antlr.runtime.ANTLRStringStream;
import org.antlr.runtime.CommonTokenStream;
import org.antlr.runtime.RecognitionException;
import org.antlr.runtime.TokenStream;
import org.antlr.runtime.tree.CommonTree;
import java.io.*;
import org.antlr.runtime.*;


public class Test{
	public static void main(String args[]){
		try{

		WateredDownTanGLexer lex = new WateredDownTanGLexer(new ANTLRInputStream(new FileInputStream(args[0])));
		TokenStream ts = new CommonTokenStream(lex);
		lex.reset();
		WateredDownTanGParser parse = new WateredDownTanGParser(ts);
		parse.tanG();
    	} catch(Exception e) {
    		System.err.println("exception: "+e);
    	}
    }	
}
