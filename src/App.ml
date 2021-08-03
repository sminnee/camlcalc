open Revery
open Revery.UI
open Revery.UI.Components

(* More concise syntax for building apps *)
let input_el ?value ?onChange=fun (_, _) -> () = ((Input.createElement ~value ~onChange ()) [@JSX])
let text_el ~fontSize ~style ~text = ((Text.createElement ~fontSize ~style ~text ()) [@JSX])
let center_el children = ((Center.createElement ~children:(Brisk_reconciler.listToElement children) ()) [@JSX])


let container_el width height children = ((Container.createElement ~width ~height ~children:(Brisk_reconciler.listToElement children) ()) [@JSX])
let column_el children = ((Column.createElement ~children:(Brisk_reconciler.listToElement children) ()) [@JSX])
let row_el children = ((Row.createElement ~children:(Brisk_reconciler.listToElement children) ()) [@JSX])

let%component main () =
  let%hook (expr, setExpr) = React.Hooks.state "3 + 2" in

  let update x _ = setExpr(fun _ -> x) in

  let lexbuf x = Lexing.from_string x in
  let parse x = Parser.expr Lexer.read (lexbuf x) in
  let parsed x =
    try
      Float.to_string (Expression.eval (parse x))
    with e ->  Printexc.to_string e in

    container_el 512 384 [
      row_el [
        input_el
          ~value: expr
          ~onChange: update
          ~style: Style.[
            width 256
          ];
        text_el
          ~fontSize: 16.
          ~style: Style.[
            width 256;
            marginTop 24;
            color (Color.hex "#FFF");
          ]
          ~text: (parsed expr);
      ];
    ]
let main_el =
    ((main ~children:[] ())[@JSX ])

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
      (UI.start win main_el : Revery.UI.renderFunction) in
    ())
;;App.start init
