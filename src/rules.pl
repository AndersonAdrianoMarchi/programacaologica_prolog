% rules.pl
:- dynamic obs/1.
:- dynamic fired_rule/1.

% meta/1: estrutura que representa a recomendacao final
% Ex.: resultado(plano(premium), preco_mensal(29.9), preco_anual(322.92), addons([sports])).
meta(resultado(plano(Plano), preco_mensal(Preco), preco_anual(PrecoAnual), addons(Addons), motivos(Motivos))) :-
    cleanup_fired,
    derive_needs(Needs),
    evaluate_budget(Budget),
    match_plan(Needs, Budget, Plano),
    plano(Plano, Preco, _, _, _),
    calculate_annual(Preco, PrecoAnual),
    findall(A, recommend_addon(A), Addons0),
    sort(Addons0, Addons),
    collect_fired(Motivos),
    Preco = Preco.  % força Preco a existir (garantia)

%% ====== Coleta de necessidades (regras que disparam) ======
derive_needs(Needs) :-
    ( obs(pref_qualidade(Q)), assert_fired(needs_qualidade(Q)) ; true ),
    ( obs(simultaneas(N)), assert_fired(needs_simultaneas(N)) ; true ),
    ( obs(usuarios_familia(sim)) -> assert_fired(needs_familia) ; true ),
    ( obs(pref_sem_anuncios(sim)) -> assert_fired(needs_sem_anuncios) ; true ),
    ( obs(pref_alta_resolucao(sim)) -> assert_fired(needs_alta_resolucao) ; true ),
    ( obs(pref_esportes(sim)) -> assert_fired(needs_esportes) ; true ),
    ( obs(tem_desconto_estudantil(sim)) -> assert_fired(needs_estudante) ; true ),
    ( obs(pref_musica(sim)) -> assert_fired(needs_musica) ; true ),
    Needs = ok.

%% ====== Oraculo de budget ======
evaluate_budget(high) :- obs(budget(alto)), assert_fired(budget_alto), !.
evaluate_budget(medium) :- obs(budget(medio)), assert_fired(budget_medio), !.
evaluate_budget(low) :- obs(budget(baixo)), assert_fired(budget_baixo), !.
evaluate_budget(medium) :- % default se nao informado
    assert_fired(budget_default), !.

%% ====== Regras para recomendar add-ons ======
recommend_addon(sports) :- obs(pref_esportes(sim)), assert_fired(addon_sports).
recommend_addon(kids)   :- obs(have_kids(sim)), assert_fired(addon_kids).
recommend_addon(music)  :- obs(pref_musica(sim)), assert_fired(addon_music).

%% ====== Regras de mapeamento necessidade -> plano (pelo menos 8 regras/combinações) ======

% Regra 1: estudante que tem budget baixo -> plano student
match_plan(_, low, student) :-
    obs(tem_desconto_estudantil(sim)), assert_fired(rule_student_low), !.

% Regra 2: familia grande (marcou usuarios_familia) e precisa muitas telas -> family
match_plan(_, _, family) :-
    obs(usuarios_familia(sim)),
    obs(simultaneas(N)), N >= 4,
    assert_fired(rule_family), !.

% Regra 3: precisa de 4K e muitas telas -> premium
match_plan(_, high, premium) :-
    obs(pref_alta_resolucao(sim)),
    obs(simultaneas(N)), N >= 2,
    assert_fired(rule_4k_high), !.

% Regra 4: precisa de 4K, budget medio -> premium (prioriza qualidade)
match_plan(_, medium, premium) :-
    obs(pref_alta_resolucao(sim)),
    obs(simultaneas(N)), N >= 2,
    assert_fired(rule_4k_medium), !.

% Regra 5: precisa de 2 telas e sem anuncios -> standard
match_plan(_, medium, standard) :-
    obs(simultaneas(2)),
    obs(pref_sem_anuncios(sim)),
    assert_fired(rule_standard_2_noads), !.

% Regra 6: baixa necessidade (1 tela, quer barato) -> lite
match_plan(_, low, lite) :-
    obs(simultaneas(1)),
    obs(pref_sem_anuncios(nao)),
    assert_fired(rule_lite_low), !.

% Regra 7: 1 tela, prefere sem anuncios e budget low/medium -> basic
match_plan(_, medium, basic) :-
    obs(simultaneas(1)),
    obs(pref_sem_anuncios(sim)),
    assert_fired(rule_basic_noads), !.

% Regra 8: Default: standard se nada mais se aplica
match_plan(_, _, standard) :-
    assert_fired(rule_default_standard).

% Observacao: a ordem das regras define prioridades; use cortes (!) para impedir backtracking onde apropriado.

%% ====== Helpers ======
calculate_annual(Mensal, ValorAnual) :-
    desconto_anual(DescontoPerc),
    Total is Mensal * 12,
    ValorAnual is round(Total * (100 - DescontoPerc) / 100 * 100) / 100. % arredonda 2 decimais

%% ====== Mecanismo de trilha (registro de regras disparadas) ======
assert_fired(Rule) :-
    ( fired_rule(Rule) -> true ; assertz(fired_rule(Rule)) ).

cleanup_fired :-
    retractall(fired_rule(_)).

collect_fired(Motivos) :-
    findall(R, fired_rule(R), Motivos).

%% ====== Tratamento de incerteza/checagens simples ======
% Se campos essenciais nao informados, meta falha:
meta(_) :-
    \+ obs(simultaneas(_)), format("Falta informacao: numero de telas simultaneas.~n"), fail.
