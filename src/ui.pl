% ui.pl
:- dynamic obs/1.

% pergunta_s/2: pergunta sim/nao e registra obs(Campo, sim/nao)
pergunta_s(Campo, Texto) :-
    format("~w (s/n): ", [Texto]),
    read(Ans0),
    ( downcase_atom(Ans0, Ans) ->
        ( Ans == s -> Term =.. [Campo, sim], assertz(obs(Term))
        ; Ans == n -> Term =.. [Campo, nao], assertz(obs(Term))
        ; format("Entrada invalida. Digite s ou n.~n"), pergunta_s(Campo, Texto)
        )
    ; format("Entrada invalida. Digite s ou n.~n"), pergunta_s(Campo, Texto)
    ).

coletar_observacoes :-
    format("Numero de telas simultaneas (ex: 1,2,3): "),
    read(N), integer(N), N>0, assertz(obs(simultaneas(N))),
    format("Prefere qualidade alta (4K)? (s/n) "),
    read(Q0), downcase_atom(Q0, Q),
    (Q == s -> assertz(obs(pref_alta_resolucao(sim))) ; assertz(obs(pref_alta_resolucao(nao)))),
    format("Prefere sem anuncios? (s/n) "),
    read(A0), downcase_atom(A0, A),
    (A == s -> assertz(obs(pref_sem_anuncios(sim))) ; assertz(obs(pref_sem_anuncios(nao)))),
    format("Tem preferencia por esportes ao vivo? (s/n) "),
    read(E0), downcase_atom(E0, E),
    (E == s -> assertz(obs(pref_esportes(sim))) ; assertz(obs(pref_esportes(nao)))),
    format("Ha criancas / necessidade de conteudo infantil? (s/n) "),
    read(K0), downcase_atom(K0, K),
    (K == s -> assertz(obs(have_kids(sim))) ; assertz(obs(have_kids(nao)))),
    format("Deseja servico de musica junto? (s/n) "),
    read(M0), downcase_atom(M0, M),
    (M == s -> assertz(obs(pref_musica(sim))) ; assertz(obs(pref_musica(nao)))),
    format("Usuario e estudante (tem desconto)? (s/n) "),
    read(S0), downcase_atom(S0, S),
    (S == s -> assertz(obs(tem_desconto_estudantil(sim))) ; assertz(obs(tem_desconto_estudantil(nao)))),
    format("E qual e seu orcamento? (alto/medio/baixo) "),
    read(Orc), downcase_atom(BudAtom, Orc),
    ( member(BudAtom, [alto,medio,baixo]) -> assertz(obs(budget(BudAtom))); format("Entrada invalida. Use alto/medio/baixo.~n"), coletar_observacoes ).

cleanup :- retractall(obs(_)), retractall(fired_rule(_)).
