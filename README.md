# Caml Calc

This is my first OCaml project, learning about parsers & interpreters. It's a simple non-interactive notebook
calculator.

## Usage (not yet implemented)

test.calc has a simple mortgage calculator copied from the calc.io homepage.

```
price = 350000
down_payment = 0.2 * price
finance_amount = price - down_payment
interest_rate  = 0.037
term = 30
n = term * 12
r = interest_rate / 12
monthly_payment = r / (1 - (1+r)^(-n)) * finance_amount
```

Run camlcalc on this file like so:

```
> ocaml src/camlcalc.ml examples/test.calc
```

It will output the result of every calculation in the file:

```
price = 350,000
down_payment = 70,000
finance_amount = 280,000
interest_rate  = 0.037
term = 30
n = 360
r = 0.0031
monthly_payment = 1,288.7923
```