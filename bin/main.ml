open Core

type command = ParseFile of string
    | NoArguments

exception Argument_Error of string

(* Returns the content of the source file or throws an exception *)
let source_content =
    let args = Sys.get_argv () in
    if (Array.length args) < 2 then
        raise (Argument_Error "Usage: camlcalc.ml [input file]");

    Core.In_channel.read_all args.(1);;

(*

let () =
    let line = source_content in
    print_endline line;
    Out_channel.flush stdout;

*)