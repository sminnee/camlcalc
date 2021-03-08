%token <float> NUMBER
%token MUL
%token DIV
%token PLUS
%token MINUS
%token POWER
%token LEFT_PAREN
%token RIGHT_PAREN
%token EOF

%start <Expression.t> expr
%%

expr:
  | a = additive; EOF
    { a }

additive:
  | a = multiplicative; PLUS; b = multiplicative
    { Expression.Op (Expression.Plus, a, b) }
  | a = multiplicative; MINUS; b = multiplicative
    { Expression.Op (Expression.Minus, a, b) }
  | a = multiplicative
    { a }

multiplicative:
  | a = exponent; MUL; b = exponent
    { Expression.Op (Expression.Multiply, a, b) }
  | a = exponent; DIV; b = exponent
    { Expression.Op (Expression.Divide, a, b) }
  | a = exponent
    { a }

exponent:
  | a = primary; POWER; b = primary
    { Expression.Op (Expression.Power, a, b) }
  | a = primary
    { a }

primary:
  | a = NUMBER
    { Expression.Number a }
  | LEFT_PAREN a = additive RIGHT_PAREN
    { a }
