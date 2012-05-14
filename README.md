# Introduction to Tandem

Tandem is a node-based scripting language used for performing simulations. It's useful for writing simulations, hardware descriptions, and other programs that are best expressed as state-machines that involve transitions between functions. Tandem's a general-purpose language though, so you can use it for anything else, and you can import any Ruby class and use it in your code too!

# Dependencies

* Java 1.5 or greater
* [Apache Ant](http://ant.apache.org/) 1.8 or above
* [Bash](http://www.gnu.org/software/bash/)
* AWK
* sed

# Downloaded Dependencies

* [Apache Ivy](http://ant.apache.org/ivy/index.html)
* [ANTLR3](http://www.antlr.org) (for compiling the grammar)
* [JUnit](http://www.junit.org/) (for running the compiler tests)
* [Ruby 1.9.2+](http://www.ruby-lang.org/en/) (Tandem uses JRuby by default)

Except for Java, Ant, Bash, and Awk, all the other dependencies will be downloaded for you if you use Ant, thanks to Apache Ivy. If you are using a modern Linux distribution or are using Mac OS X, you should have or will be able to download all of these dependencies easily.

If you want to use a more recent version of any of these dependencies, download the corresponding JAR file and place it in the `lib` directory. Tandem will also prefer any system Ruby you have installed over the downloaded JRuby.

Support for Windows is limited to Ant. Note that you will need to compile all imported files yourself if you are on Windows. See further instructions below. On Unix systems, the Tandem compiler will take care of this for you.


To install ANTLR manually, first download the [JAR file](http://www.antlr.org/download.html). Make sure that you add the path to the JAR file to your classpath.

# Installation and Compilation

First, clone the repository with git, or download a zipped version of the current repository and extract it to some directory you'll remember.

	$ git clone git://github.com/vrdabomb5717/Tandem.git
	$ cd Tandem

Next, explore the Tandem compiler options or create a Tandem file.

	$ ./tandem --help
	Usage: tandem [options] [filename]
		options:
	      -b --ruby     Attempt to use system Ruby. If not valid, use JRuby.
	      -c --compile  Only compile Tandem file.
	      -d --deps     Resolve dependencies and download needed files.
	      -h --help     List Tandem usage and options.
	      -j --jruby    Use downloaded JRuby.
	      -r --run      Assume compiled Ruby file exists and try running file.
	      -v --version  Print Tandem version.
	      -w --whole    Compile and run Tandem file.

	$ touch example.td
	$ echo 'Println "Hello World!"' >> example.td
	$ ./tandem example.td
	resolving dependencies...
	compiling...
	Hello World!

By default, the Tandem compiler will compile and run your file. Compiled files are just Ruby files, so you can re-run them by using `./tandem -r` or by just running `ruby` on the compiled file. This compiled Ruby file is located in the same directory as the corresponding Tandem file.

For more information on the Tandem programming language, or a tutorial, see the latest version of the Tandem Project Report.

# Using Tandem on Windows

The easiest way to use Tandem is to use Ant, a tool similar to `make`. First, clone the Tandem git repository, or if you do not have git installed, download a zip file and extract that folder to some location you'll remember.

	$ git clone git://github.com/vrdabomb5717/Tandem.git
	$ cd Tandem

Now, create the build, dist, lib, and grammar directories, download the dependencies, and compile the grammar:

	$ ant init
	$ ant grammar

At this point, the file will complain if it cannot find ANTLR in your classpath.

Compile the rest of the files, and try running the tests:

	$ ant compile
	$ ant test

Running `ant test` will create the needed directories, compile the grammar, compile the parser and lexer, and test the files using JUnit. It may be easier to just use that.

For more specific tests, `ant gunit_test` will run the grammar tests and `ant parse_test` will run the parser tests that require JUnit.

To compile a `.td` file, run `ant walk` with a filename provided as an argument.

For example, try compiling the file expression.td:

	$ ant walk -Dfile=test/expression/expression.td

Again, note that if you choose to import any `.td` files, you will need to compile all the imported files before you are able to compile and run your file.

Now, run the compiled `.rb` file.

	$ ruby test/expression/expression.rb

# Cleaning up and Uninstalling Tandem

To clean up without deleting your entire Tandem installation, run `ant clean`. To clean up the dependencies that you have downloaded as well, run `ant clean-ivy`.

If you would like to remove the entire Tandem installation, just delete the entire Tandem directory.


# Compilation without using Ant

To compile the grammar file, assuming that ANTLR is on your classpath, run:

	$ java org.antlr.Tool TanG.g
	$ javac TandemTree.java
	$ java TandemTree $INPUTFILE

More instructions will come at a later date!

# Known Bugs

* You cannot currently chain method calls when using imported Ruby code.
* If you do not use the main Tandem compiler, you will need to compile all imported Tandem files, recursively, before you compile the specified .td file.
