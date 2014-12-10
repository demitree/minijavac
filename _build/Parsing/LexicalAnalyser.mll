{
  type lexeme =
    | EOF
    | PLUS
    | MINUS
    | DIV
    | TIMES
    | FLOAT of float
    | IDENT of string

  let print_lexeme = function
    | EOF     -> print_string "EOF"
    | PLUS    -> print_string "PLUS"
    | MINUS   -> print_string "MINUS"
    | DIV     -> print_string "DIV"
    | TIMES   -> print_string "TIMES"
    | FLOAT f -> print_string "FLOAT("; print_float f; print_string ")"
    | IDENT s -> print_string "IDENT("; print_string s; print_string ")"
}

let letter = ['a'-'z' 'A'-'Z']
let digit = ['0'-'9']
let real = digit* ('.' digit*)?
let ident = letter (letter | digit | '_')*
let space = [' ' '\t' '\n']

rule nexttoken = parse
  | space+        { nexttoken lexbuf }
  | eof           { EOF }
  | "+"           { PLUS } 
  | "-"           { MINUS } 
  | "/"           { DIV } 
  | "*"           { TIMES } 
  | real as nb    { FLOAT (float_of_string nb) }
  | ident as str  { IDENT str }

{
  let rec examine_all lexbuf =
    let res = nexttoken lexbuf in
    print_lexeme res;
    print_string " ";
    match res with
    | EOF -> ()
    | _   -> examine_all lexbuf
}