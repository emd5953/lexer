Project 3 by Enrin Debbarma
emd5953@psu.edu

Lexical Analysis is one of the first phases of a compiling process. Lexical analyzer
1) Takes a program source as an input stream
2) Breaks the source into the sequence of lexemes that are meaningful units of words for tokens
3) Generates tokens, each of which is a pair of a token name/type and its attribute of its  corresponding lexeme
4) Passes the pair to a parser calling the lexer sequentially.

The lexical analyzer additionally 
5) Adds new identifiers into the symbol table
6) Optionally handles a compiler directive #define that replaces a word to another word.

Steps for running: 

1. goto "src" directory

2. compile Lexer.jflex as follows
   java -jar jflex-1.6.1.jar Lexer.flex

3. compile all java files

4. run program and capture its output as follows:

java Program test1.minc > solu1.txt

and so on....
5. Replace  destination directory in line ## args = new String[] { ".\\test\\testpreproc.minc" }; 
   in Program.java to test other test cases
