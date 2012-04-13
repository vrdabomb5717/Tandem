# Introduction to Tandem

Tandem is a node-based, general purpose programming language. It's useful for writing simulations, hardware descriptions, and other programs that are best expressed as state-machines that involve transitions between functions.

# Dependencies

* [ANTLR](http://www.antlr.org)

To install ANTLR, first download the [JAR file](http://www.antlr.org/download.html). Make sure that you add the path to the JAR file to your classpath.

# Compilation and Installation

To compile the grammar file, assuming that ANTLR is on your classpath, run:

	$ java org.antlr.Tool TanG.g
	$ javac TandemTree.java
	$ java TandemTree $INPUTFILE