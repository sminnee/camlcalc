open Revery
open Revery.UI
open Revery.UI.Components

module Styles = struct
  open Style

  let text = [
    marginTop 24;
    color (Color.hex "#FFF");
  ]
end

let%component main () =
  let%hook (expr, setExpr) = React.Hooks.state "3 + 2" in

  let update x _ = setExpr(fun _ -> x) in

  let lexbuf x = Lexing.from_string x in
  let parse x = Parser.expr Lexer.read (lexbuf x) in
  let parsed x =
    try
      Float.to_string (Expression.eval (parse x))
    with e ->  Printexc.to_string e in

  ((Center.createElement
    ~children: [
      ((Input.createElement
        ~value: expr
        ~onChange: update
      ()) [@JSX]);

      ((Text.createElement
        ~fontSize: 16.
        ~style: Styles.text
        ~text: (parsed expr)
      ()) [@JSX ]);
    ]
  ()) [@JSX ])

let init app =
  Revery.App.initConsole ();

  let consoleReporter = Timber.Reporter.console ~enableColors:true () in

  Timber.App.enable(consoleReporter);
  Timber.App.setLevel(Timber.Level.perf);

  (let win =
      App.createWindow app "CamlCalc"
        ~createOptions:(WindowCreateOptions.create
                          ~backgroundColor:(Color.hex "#AAF")
                          ~width:512 ~height:384 ()) in
    let _update =
      (UI.start win ((main ~children:[] ())[@JSX ]) : Revery.UI.renderFunction) in
    ())
;;App.start init
