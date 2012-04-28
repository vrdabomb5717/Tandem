# Introduction to Tandem

Tandem is a node-based, general purpose programming language. It's useful for writing simulations, hardware descriptions, and other programs that are best expressed as state-machines that involve transitions between functions.

# Dependencies

* Java 1.5 or greater
* [ANTLR3](http://www.antlr.org) (if you want to compile the grammar)
* [Apache Ant](http://ant.apache.org/)
* [JUnit](http://www.junit.org/) (for running the compiler tests)

To install ANTLR, first download the [JAR file](http://www.antlr.org/download.html). Make sure that you add the path to the JAR file to your classpath.

Tandem includes a version of JUnit for running tests. However, this
version may be out of date. It is recommended that you use the newest
version of JUnit to run the unit tests.

# Compilation and Installation using Ant

The easiest way to use Tandem is to use Ant, a tool similar to *make*.

	$ git clone git://github.com/vrdabomb5717/Tandem.git
	$ cd Tandem

Now, create the build, dist, lib, and grammar directories, and compile the grammar:

	$ ant init
	$ ant grammar

At this point, the file will complain if it cannot fine ANTLR in your classpath.

Compile the rest of the files, and try running the tests:

	$ ant compile
	$ ant test

Running `ant test` will create the needed directories, compile the grammar, compile the parser and lexer, and test the files using JUnit. It may be easier to just use that.

You can also try traversing the tree:

	$ ant walk -Dfile=test/expression/expression.td


# Compilation and Installation without using Ant

To compile the grammar file, assuming that ANTLR is on your classpath, run:

	$ java org.antlr.Tool TanG.g
	$ javac TandemTree.java
	$ java TandemTree $INPUTFILE
