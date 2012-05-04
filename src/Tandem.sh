#!/bin/bash

EXPECTED_ARGS=1
E_BADARGS=65

if [ $# -ne $EXPECTED_ARGS ]
then
  echo "Usage: `basename $0` {arg}"
  exit $E_BADARGS
fi

FILE=$1


if [[ "$FILE" == *.td ]]
then
  echo "valid filename"
else
     echo "invalid filename"
     exit
fi

if [ -f "$FILE" ]
then
    echo the file exists
else
    echo the file does not exist
    exit
fi

#check java
#check ant 1.8
#check ruby 1.9.2

if type -p java; then
    echo found java executable in PATH
    _java=java
elif [[ -n "$JAVA_HOME" ]] && [[ -x "$JAVA_HOME/bin/java" ]];  then
    echo found java executable in JAVA_HOME     
    _java="$JAVA_HOME/bin/java"
else
    echo "no java"
fi

if [[ "$_java" ]]; then
    version=$("$_java" -version 2>&1 | awk -F '"' '/version/ {print $2}')
    echo version "$version"
    if [[ "$version" > "1.5" ]]; then
        echo version is more than 1.5
    else         
        echo version is less than 1.5
	exit
    fi
fi



if type -p ant; then
    echo found ant executable in PATH
    _ant=ant
elif [[ -x "usr/bin/env ant" ]];  then
    echo found ant executable in ENV_ANT     
    _ant="usr/bin/env ant"
else
    echo "no ant"
    exit
fi

if [[ "$_ant" ]]; then
    version=$("$_ant" -v 2>&1 | awk -F ' ' '/ / {print $4}')
    echo version "$version"
    if [[ "$version" > "1.8.0" ]]; then
        echo version is more than 1.8
    else         
        echo version is less than 1.8
	exit
    fi
fi


if type -p ruby; then
    echo found ruby executable in PATH
    _ruby=ruby
elif [[ -x "usr/bin/env ruby" ]];  then
    echo found ant executable in ENV_ANT     
    _ruby="usr/bin/env ruby"
else
    echo "no ruby"
    exit
fi

if [[ "$_ruby" ]]; then
    version=$("$_ruby" -v 2>&1 | awk -F ' ' '/ / {print $2}')
    echo version "$version"
    if [[ "$version" > "1.9.2" ]]; then
        echo version is more than 1.9.2
    else         
        echo version is less than 1.9.2
	exit
    fi
fi


if java org.antlr.Tool; then
    #echo found ANTLR executable in PATH
    _antlr=$(java org.antlr.Tool)
elif [[ -x "usr/bin/env ruby" ]];  then
    #echo found ant executable in ENV_ANT     
    _antlr="usr/bin/env ruby"
else
    echo "no ANTLR"  
    exit  
fi

version=$(java org.antlr.Tool -version 2>&1 | awk -F ' ' '/ / {print $5}')
    
echo version "$version"


case `echo "a=$version;b=3.4;r=-1;if(a==b)r=0;if(a>b)r=1;r"|bc` in
           0) 
        ;; 1)	      
        ;; *) 
	      echo "No ANTLR"
	      exit
        ;; esac
    
echo ANTLR version greater than 3.4

java TandemTree "$FILE" &

ruby_file=${FILE%%.*}

ruby "$ruby_file".rb &




