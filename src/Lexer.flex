import java.util.HashMap;

%%

%class Lexer
%byaccj

%{ 
  
  public Parser   parser;
  public int      lineno;
  public int      column;
  public int      tokenStartColumn;  // Holds the starting column for the current token
  private HashMap<String, Integer> symbolTable = new HashMap<>(); // Stores identifiers

  private HashMap<String, String> macroMap = new HashMap<>();

  public HashMap<String, Integer> getSymbolTable() {
      return symbolTable;
  }

  public Lexer(java.io.Reader r, Parser parser) {
    this(r);
    this.parser = parser;
    this.lineno = 1;
    this.column = 1;
  }
%}

int         = [0-9]+
float       = [0-9]+"."[0-9]+
identifier  = [a-zA-Z][a-zA-Z0-9_]*
newline     = \n
whitespace  = [ \t\r]+
linecomment = "%%".*
blockcomment = "%*"[^]*"*%"

%%

/* NEW RULE FOR #define DIRECTIVE */

"#define"[ \t]+({identifier})[ \t]+({identifier}|{int}|{float})[ \t]* {
    // Remove "#define" and any trailing newline.
    String noDefine = yytext().replaceFirst("^#define\\s+", "").trim();
    noDefine = noDefine.replaceAll("\\n", "");
    String[] parts = noDefine.split("\\s+");
    if (parts.length >= 2) {
        String macroName = parts[0];
        String macroReplacement = parts[1].trim();
        macroMap.put(macroName, macroReplacement);
    }
    column += yytext().length();
    /* Do not return a token for #define lines */
}

"int" { 
    tokenStartColumn = column; 
    parser.yylval = new ParserVal((Object)yytext()); 
    column += yytext().length();
    return Parser.INT; 
}
"print" { 
    tokenStartColumn = column; 
    parser.yylval = new ParserVal((Object)yytext()); 
    column += yytext().length();
    return Parser.PRINT; 
}
"void" { 
    tokenStartColumn = column; 
    parser.yylval = new ParserVal((Object)yytext()); 
    column += yytext().length();
    return Parser.VOID; 
}
"bool" { 
    tokenStartColumn = column; 
    parser.yylval = new ParserVal((Object)yytext()); 
    column += yytext().length();
    return Parser.BOOL; 
}
"float" { 
    tokenStartColumn = column; 
    parser.yylval = new ParserVal((Object)yytext()); 
    column += yytext().length();
    return Parser.FLOAT; 
}
"struct" { 
    tokenStartColumn = column; 
    parser.yylval = new ParserVal((Object)yytext());
    column += yytext().length();
    return Parser.STRUCT; 
}
"size" { 
    tokenStartColumn = column; 
    parser.yylval = new ParserVal((Object)yytext()); 
    column += yytext().length();
    return Parser.SIZE; 
}
"new" { 
    tokenStartColumn = column; 
    parser.yylval = new ParserVal((Object)yytext());  
    column += yytext().length();
    return Parser.NEW; 
}
"if" { 
    tokenStartColumn = column; 
    parser.yylval = new ParserVal((Object)yytext());
    column += yytext().length();
    return Parser.IF; 
}
"else" { 
    tokenStartColumn = column; 
    parser.yylval = new ParserVal((Object)yytext()); 
    column += yytext().length();
    return Parser.ELSE; 
}
"while" { 
    tokenStartColumn = column; 
    parser.yylval = new ParserVal((Object)yytext());
    column += yytext().length();
    return Parser.WHILE; 
}
"return" { 
    tokenStartColumn = column; 
    parser.yylval = new ParserVal((Object)yytext());
    column += yytext().length();
    return Parser.RETURN; 
}
"break" { 
    tokenStartColumn = column; 
    parser.yylval = new ParserVal((Object)yytext());
    column += yytext().length();
    return Parser.BREAK; 
}
"continue" { 
    tokenStartColumn = column; 
    parser.yylval = new ParserVal((Object)yytext());
    column += yytext().length();
    return Parser.CONTINUE; 
}
"true" { 
    tokenStartColumn = column; 
    parser.yylval = new ParserVal((Object)yytext());
    column += yytext().length();
    return Parser.TRUE; 
}
"false" { 
    tokenStartColumn = column; 
    parser.yylval = new ParserVal((Object)yytext()); 
    column += yytext().length();
    return Parser.FALSE; 
}

"[" { 
    tokenStartColumn = column; 
    parser.yylval = new ParserVal((Object)yytext());
    column += yytext().length();
    return Parser.LBRACKET; 
}
"]" { 
    tokenStartColumn = column; 
    parser.yylval = new ParserVal((Object)yytext());
    column += yytext().length();
    return Parser.RBRACKET; 
}
"," { 
    tokenStartColumn = column; 
    parser.yylval = new ParserVal((Object)yytext());
    column += yytext().length();
    return Parser.COMMA; 
}
"." { 
    tokenStartColumn = column; 
    parser.yylval = new ParserVal((Object)yytext());
    column += yytext().length();
    return Parser.DOT; 
}
"<-" { 
    tokenStartColumn = column; 
    parser.yylval = new ParserVal((Object)yytext());
    column += yytext().length();
    return Parser.ASSIGN; 
}
"&" { 
    tokenStartColumn = column; 
    parser.yylval = new ParserVal((Object)yytext());
    column += yytext().length();
    return Parser.AMPERSAND; 
}
"@" { 
    tokenStartColumn = column; 
    parser.yylval = new ParserVal((Object)yytext());
    column += yytext().length();
    return Parser.AT; 
}

"{" { 
    tokenStartColumn = column; 
    parser.yylval = new ParserVal((Object)yytext());
    column += yytext().length();
    return Parser.BEGIN; 
}
"}" { 
    tokenStartColumn = column; 
    parser.yylval = new ParserVal((Object)yytext());
    column += yytext().length();
    return Parser.END; 
}
"(" { 
    tokenStartColumn = column;  
    parser.yylval = new ParserVal((Object)yytext());
    column += yytext().length();
    return Parser.LPAREN; 
}
")" { 
    tokenStartColumn = column;  
    parser.yylval = new ParserVal((Object)yytext());
    column += yytext().length();
    return Parser.RPAREN; 
}
";" { 
    tokenStartColumn = column;  
    parser.yylval = new ParserVal((Object)yytext());
    column += yytext().length();
    return Parser.SEMI; 
}

"-" { 
    tokenStartColumn = column;  
    parser.yylval = new ParserVal((Object)yytext());
    column += yytext().length();
    return Parser.OP; 
}
"*" { 
    tokenStartColumn = column;  
    parser.yylval = new ParserVal((Object)yytext());
    column += yytext().length();
    return Parser.OP; 
}
"/" { 
    tokenStartColumn = column;  
    parser.yylval = new ParserVal((Object)yytext());
    column += yytext().length();
    return Parser.OP; 
}
"%" { 
    tokenStartColumn = column;  
    parser.yylval = new ParserVal((Object)yytext());
    column += yytext().length();
    return Parser.OP; 
}
"and" { 
    tokenStartColumn = column;  
    parser.yylval = new ParserVal((Object)yytext());
    column += yytext().length();
    return Parser.OP; 
}
"or" { 
    tokenStartColumn = column;  
    parser.yylval = new ParserVal((Object)yytext());
    column += yytext().length();
    return Parser.OP; 
}
"not" { 
    tokenStartColumn = column;  
    parser.yylval = new ParserVal((Object)yytext());
    column += yytext().length();
    return Parser.OP; 
}
"=" { 
    tokenStartColumn = column;  
    parser.yylval = new ParserVal((Object)yytext());
    column += yytext().length();
    return Parser.RELOP; 
}
"<>" { 
    tokenStartColumn = column;  
    parser.yylval = new ParserVal((Object)yytext());
    column += yytext().length();
    return Parser.RELOP; 
}
">" { 
    tokenStartColumn = column;  
    parser.yylval = new ParserVal((Object)yytext());
    column += yytext().length();
    return Parser.RELOP; 
}
"<=" { 
    tokenStartColumn = column;  
    parser.yylval = new ParserVal((Object)yytext());
    column += yytext().length();
    return Parser.RELOP;
}
">=" { 
    tokenStartColumn = column;  
    parser.yylval = new ParserVal((Object)yytext());
    column += yytext().length();
    return Parser.RELOP; 
}

"+" { 
    tokenStartColumn = column;  
    parser.yylval = new ParserVal((Object)yytext());
    column += yytext().length();
    return Parser.OP; 
}
"<" { 
    tokenStartColumn = column;  
    parser.yylval = new ParserVal((Object)yytext());
    column += yytext().length();
    return Parser.RELOP; 
}

{float} { 
    tokenStartColumn = column;  
    parser.yylval = new ParserVal((Object)yytext());
    column += yytext().length();
    return Parser.FLOAT_VALUE;  
}

{int} { 
    tokenStartColumn = column;  
    parser.yylval = new ParserVal((Object)yytext());
    column += yytext().length();
    return Parser.INT_VALUE; 
}

{identifier} {
    tokenStartColumn = column;
    String originalText = yytext();
    
    // Check if the identifier has a macro definition.
    if (macroMap.containsKey(originalText)) {
        String expansion = macroMap.get(originalText);
        // Choose token based on the expansion.
        if (expansion.equals("int")) {
            parser.yylval = new ParserVal(expansion);
            column += originalText.length();
            return Parser.INT;
        } else if (expansion.equals("bool")) {
            parser.yylval = new ParserVal(expansion);
            column += originalText.length();
            return Parser.BOOL;
        } else if (expansion.matches("[0-9]+\\.[0-9]+")) {
            float floatVal = Float.parseFloat(expansion);
            ParserVal pval = new ParserVal(floatVal);  // Declare pval right here
            pval.obj = floatVal;                       // Set the obj field explicitly
            parser.yylval = pval;
            column += originalText.length();
            return Parser.FLOAT_VALUE;     
        } else if (expansion.matches("[0-9]+")) {
            int intVal = Integer.parseInt(expansion);
            ParserVal pval = new ParserVal(intVal);
            pval.obj = intVal;  // Explicitly set the obj field
            parser.yylval = pval;
            column += originalText.length();
            return Parser.INT_VALUE;
        } else {
            // Fallback: treat as a normal identifier with the expanded value.
            parser.yylval = new ParserVal(expansion);
            column += originalText.length();
            return Parser.ID;
        }
    }
    
    // Normal identifier handling if no macro matches.
    int symId;
    if (!symbolTable.containsKey(originalText)) {  
        symId = symbolTable.size();  // Assign a unique ID
        symbolTable.put(originalText, symId);  
        System.out.print("<<new symbol table entity [" + symId + ", \"" + originalText + "\"]>>");  
    } else {
        symId = symbolTable.get(originalText);  
    }
    parser.yylval = new ParserVal((Object)originalText);
    column += originalText.length();
    return Parser.ID;
}


{linecomment} { 
    tokenStartColumn = column;  
    System.out.print(yytext());
    column += yytext().length(); 
}
{whitespace} { 
    // Print the whitespace (if the output should include it)
    System.out.print(yytext());
    // Update column: count each character (adjust tabs if needed)
    for (char c : yytext().toCharArray()) {
        column += (c == '\t') ? 4 : 1;  // Here, one tab equals 4 columns (change as needed)
    }
}
{newline} { 
    System.out.println(); 
    lineno++; 
    column = 1; 
}
{blockcomment} { 
    // Print the block comment exactly as in the input.
    System.out.print(yytext());
    // Update column and line counts based on the comment text.
    int lastNewline = yytext().lastIndexOf('\n');
    if (lastNewline == -1) {
        column += yytext().length();
    } else {
        column = yytext().length() - lastNewline;
    }
    int newlines = 0;
    for (char c : yytext().toCharArray()) {
        if (c == '\n') {
            newlines++;
        }
    }
    lineno += newlines;
}

\b { 
    System.err.println("Sorry, backspace doesn't work"); 
}

/* error fallback */
. {
    // Flush the token output by printing a newline
    System.out.println();
    System.err.println("Lexical error: unexpected character '" + yytext() +
                       "' at " + lineno + ":" + column + ".");
    System.exit(1);
}
