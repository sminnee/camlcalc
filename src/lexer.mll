{

open Parser
exception SyntaxError of string

}

let digit = ['0'-'9']
let frac = '.' digit*
let exp = ['e' 'E'] ['-' '+']? digit+
let float = digit+ frac? exp?
let white = [' ' '\t']+

rule read =
  parse
  | white { read lexbuf }
  | float { NUMBER (float_of_string (Lexing.lexeme lexbuf)) }
  | '('   { LEFT_PAREN }
  | ')'   { RIGHT_PAREN }
  | '*'   { MUL }
  | '/'   { DIV }
  | '+'   { PLUS }
  | '-'   { MINUS }
  | '^'   { POWER }
  | _     { raise (SyntaxError ("Unexpected char: " ^ Lexing.lexeme lexbuf)) }
  | eof   { EOF }
