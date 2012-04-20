import org.antlr.runtime.ANTLRStringStream;
import org.antlr.runtime.CommonTokenStream;
import org.antlr.runtime.RecognitionException;
import org.antlr.runtime.TokenStream;
import org.antlr.runtime.tree.CommonTree;
import java.io.*;
import org.antlr.runtime.*;
import org.junit.Test;
import org.junit.BeforeClass;
import static org.junit.Assert.*;


public class TandemTest
{
    private static File currentDir = new File(".");
    private static String currentDirName;
    private static String testPath;
    private final static String whitespace = "misc/whitespace/";
    private final static String comments = "misc/comments/";

    public static void main(String args[])
    {
        try
        {
            currentDirName = currentDir.getCanonicalPath();
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }

        testPath = currentDirName + "/test/";
    }

    @BeforeClass
    public static void oneTimeSetUp()
    {
        try
        {
            currentDirName = currentDir.getCanonicalPath();
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }

        testPath = currentDirName + "/test/";
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

    public static File[] listTDFiles(File file)
    {
        File[] files = file.listFiles(new FilenameFilter() {
            @Override
            public boolean accept(File dir, String name)
            {
                if(name.toLowerCase().endsWith(".td"))
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
        });

        return files;
    }

    @Test
    public void test_whitespace()
    {
        // System.out.println(testPath + whitespace);
        File file = new File(testPath + whitespace);
        File[] files = listTDFiles(file);

        for(File f : files)
        {
            // System.out.println(f.getAbsolutePath());

            if(f != null)
            {
                // System.out.println(f.getAbsolutePath());
                assertTrue( parseFile(f.getAbsolutePath()) );
            }
        }
    }

    @Test
    public void test_comments()
    {
        // assertTrue();
    }

    @Test
    public void test_expression()
    {
        // assertTrue();
    }
}
