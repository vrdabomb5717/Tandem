import org.antlr.runtime.ANTLRStringStream;
import org.antlr.runtime.CommonTokenStream;
import org.antlr.runtime.RecognitionException;
import org.antlr.runtime.TokenStream;
import org.antlr.runtime.tree.CommonTree;
import java.io.*;
import org.antlr.runtime.*;
import org.junit.Test;
import static org.junit.Assert.*;


public class TandemTest
{
    public static void main(String args[])
    {
        // try
        // {
        //     CharStream input = new ANTLRFileStream(args[0]);
        //     TanGLexer lexer = new TanGLexer(input);

        //     TokenStream ts = new CommonTokenStream(lexer);
        //     TanGParser parse = new TanGParser(ts);
        //     parse.tanG();
        // }
        // catch(Throwable t)
        // {
        //     System.out.println("Exception: "+t);
        //     t.printStackTrace();
        // }
    }

    public static boolean parseFile(String filename)
    {
        try
        {
            CharStream input = new ANTLRFileStream(filename);
            TanGLexer lexer = new TanGLexer(input);

            TokenStream ts = new CommonTokenStream(lexer);
            TanGParser parse = new TanGParser(ts);
            parse.tanG();
        }
        catch(Throwable t)
        {
            // System.out.println("Exception: "+t);
            // t.printStackTrace();
            return false;
        }

        return true;
    }


    @Test
    public void test_empty_file()
    {
        // assertTrue();
    }
}
