public class Parser
{
    public static final int INT         = 10; // "int"
    public static final int PRINT       = 19;
    public static final int VOID        = 20;
    public static final int BOOL        = 21; // Unused for literals
    public static final int FLOAT       = 22;
    public static final int STRUCT      = 23;
    public static final int SIZE        = 24;
    public static final int NEW         = 25;
    public static final int IF          = 26;
    public static final int ELSE        = 27;
    public static final int WHILE       = 28;
    public static final int RETURN      = 29;
    public static final int BREAK       = 30;
    public static final int CONTINUE    = 31;
    public static final int TRUE        = 32;  // Boolean literal true
    public static final int FALSE       = 33;  // Boolean literal false

    public static final int LPAREN      = 11; // "("
    public static final int RPAREN      = 12; // ")"
    public static final int BEGIN       = 34;
    public static final int END         = 35;
    public static final int LBRACKET     = 36;
    public static final int RBRACKET     = 37;
    public static final int COMMA       = 38;
    public static final int DOT         = 39;
    public static final int ASSIGN      = 40;
    public static final int AMPERSAND   = 41;
    public static final int AT          = 42;

    public static final int SEMI        = 13; // ";"
    public static final int OP          = 14; // "+", "-", "*", "/", "and", "or", "not"
    public static final int RELOP       = 15; // "=", "!=", "<", ">", "<=", ">="
    public static final int INT_VALUE   = 16; // {int}
    public static final int ID          = 17; // {identifier}
    public static final int FLOAT_VALUE = 18; // {float}

    Lexer            lexer;
    Compiler         compiler;
    public ParserVal yylval;

    public Parser(java.io.Reader r, Compiler compiler) throws Exception
    {
        this.compiler = compiler;
        this.lexer    = new Lexer(r, this);
    }
    
    public int yyparse() throws java.io.IOException
    {
        while (true)
        {
            int token = lexer.yylex();
            if (token == 0)
            {
            System.out.println("Success!");
            return 0;
            }
            if (token == -1)
            {
                // error
                return -1;
            }
            
     
            ParserVal currVal = yylval;  
            Object attr = currVal.obj;
            String attrString = (attr == null) ? "null" : attr.toString();
            
            
            String pos = lexer.lineno + ":" + lexer.tokenStartColumn;
            
            if (token == ID)
            {
                
                int symId = lexer.getSymbolTable().get(attrString);
                System.out.print("<" + getTokenName(token) + ", attr:sym-id:" + symId + ", " + pos + ">");
            }
            else if (token == INT_VALUE || token == FLOAT_VALUE ||
                     token == OP || token == RELOP ||
                     token == TRUE || token == FALSE)
            {
                
                System.out.print("<" + getTokenName(token) + ", attr:\"" + attrString + "\", " + pos + ">");
            }
            else
            {
               
                System.out.print("<" + getTokenName(token) + ", " + pos + ">");
            }
        }
    }
    
    
    private String getTokenName(int token)
    {
        return switch (token) {
            case INT -> "INT";
            case INT_VALUE -> "INT_VALUE";
            case FLOAT_VALUE -> "FLOAT_VALUE";
            case ID -> "ID";
           
            case TRUE, FALSE -> "BOOL_VALUE";
            case LPAREN -> "LPAREN";
            case RPAREN -> "RPAREN";
            case SEMI -> "SEMI";
            case OP -> "OP";
            case RELOP -> "RELOP";
            case PRINT -> "PRINT";
            case VOID -> "VOID";
            case BOOL -> "BOOL";
            case FLOAT -> "FLOAT";
            case STRUCT -> "STRUCT";
            case SIZE -> "SIZE";
            case NEW -> "NEW";
            case IF -> "IF";
            case ELSE -> "ELSE";
            case WHILE -> "WHILE";
            case RETURN -> "RETURN";
            case BREAK -> "BREAK";
            case CONTINUE -> "CONTINUE";
            case BEGIN -> "BEGIN";
            case END -> "END";
            case LBRACKET -> "LBRACKET";
            case RBRACKET -> "RBRACKET";
            case COMMA -> "COMMA";
            case DOT -> "DOT";
            case ASSIGN -> "ASSIGN";
            case AMPERSAND -> "AMPERSAND";
            case AT -> "AT";
            default -> "UNKNOWN_TOKEN";
        };
    }
}
