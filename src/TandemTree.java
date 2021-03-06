import org.antlr.runtime.ANTLRStringStream;
import org.antlr.runtime.CommonTokenStream;
import org.antlr.runtime.RecognitionException;
import org.antlr.runtime.TokenStream;
import org.antlr.runtime.tree.CommonTree;
import org.antlr.runtime.tree.*;
import java.io.*;
import org.antlr.runtime.*;
import org.antlr.stringtemplate.*;

//Donald Pomeroy

public class TandemTree{
	public void printTree(CommonTree t, int indent) {
		if ( t != null ) {
			StringBuffer sb = new StringBuffer(indent);
			for ( int i = 0; i < indent; i++ )
				sb = sb.append("   ");
			for ( int i = 0; i < t.getChildCount(); i++ ) {
				System.out.println(sb.toString() + t.getChild(i).toString());
				printTree((CommonTree)t.getChild(i), indent+1);
			}
		}
	}

	public static void main(String args[]){
		try{

	 		TanGLexer lex = new TanGLexer(new ANTLRInputStream(new FileInputStream(args[0])));
	 		Token token;
	 		TokenStream ts = new CommonTokenStream(lex);
	 		lex.reset();
	 		TanGParser parse = new TanGParser(ts);
	 		TanGParser.tanG_return result = parse.tanG();
	 		CommonTree t = (CommonTree)result.getTree();
			TreeWalker walk = new TreeWalker();
			walk.walkTree(t, args[0].substring(0, args[0].length()-3));
	 		TandemTree Tr = new TandemTree();
	 	//	Tr.printTree(t, 2);
	 		DOTTreeGenerator gen = new DOTTreeGenerator();
	 		StringTemplate st = gen.toDOT(t);	
	 		try {
	 		                          	BufferedWriter out = new BufferedWriter(new FileWriter("graph.txt"));
	 		                          	 out.write(st.toString());
	 		                          	 out.close();
	 		} catch (IOException e) {}		
	 	} catch(Exception e) {
			e.printStackTrace();
	 		System.err.println("exception: "+e);
	 	}
	}	
}

