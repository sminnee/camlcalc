type op = Plus | Minus | Multiply | Divide | Power

type t =
  | Op of op * t * t
  | Number of float

let rec eval expr =
  match expr with
    | Op (Plus, a, b)     -> eval a +. eval b
    | Op (Minus, a, b)    -> eval a -. eval b
    | Op (Multiply, a, b) -> eval a *. eval b
    | Op (Divide, a, b)   -> eval a /. eval b
    | Op (Power, a, b)    -> eval a ** eval b
    | Number x            -> x
