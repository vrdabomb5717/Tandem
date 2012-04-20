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

# Compilation and Installation

To compile the grammar file, assuming that ANTLR is on your classpath, run:

	$ java org.antlr.Tool TanG.g
	$ javac TandemTree.java
	$ java TandemTree $INPUTFILE
