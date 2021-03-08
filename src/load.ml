open Parser


let parse lexbuf =
  Parser.expr Lexer.read lexbuf
