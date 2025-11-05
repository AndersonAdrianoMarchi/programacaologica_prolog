% main.pl
% Carrega módulos
:- ["kb.pl","rules.pl","ui.pl","explain.pl"].

start :-
    banner,
    menu.

banner :-
    format("~n=== Sistema Especialista - Recomendador de Planos de Streaming ===~n"),
    format("Desenvolvido por: Anderson Marchi (@seu_github)~n~n").

menu :-
    format("1) Executar consulta~n2) Sair~n> "),
    read(Opt),
    ( Opt = 1 -> run_case, cleanup, menu
    ; Opt = 2 -> format("Saindo...~n")
    ; format("Opcao invalida.~n"), menu ).

run_case :-
    cleanup,                    % garante estado limpo
    coletar_observacoes,
    ( meta(Result) ->
        explicar(Result),
        format("~nRESULTADO: ~w~n", [Result])
    ; format("~nNao foi possivel chegar a uma recomendacao. Reveja as respostas.~n")
    ),
    true.
