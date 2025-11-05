% explain.pl
:- dynamic obs/1.

explicar(resultado(plano(Plano), preco_mensal(Preco), preco_anual(PrecoAnual), addons(Addons), motivos(Motivos))) :-
    % Coleta observacoes principais (se existirem)
    (obs(simultaneas(N)) -> true ; N = desconhecido),
    (obs(pref_alta_resolucao(Alt)) -> true ; Alt = nao),
    (obs(pref_sem_anuncios(NA)) -> true ; NA = nao),
    (obs(pref_esportes(Es)) -> true ; Es = nao),
    (obs(have_kids(HK)) -> true ; HK = nao),
    (obs(pref_musica(M)) -> true ; M = nao),
    (obs(tem_desconto_estudantil(Stu)) -> true ; Stu = nao),
    (obs(orcamento(Orc)) -> true ; Orc = desconhecido),

    format("~n[Explicacao]~n"),
    format("- Regras disparadas (trilha): ~w~n", [Motivos]),
    format("- Plano recomendado: ~w~n", [Plano]),
    format("- Preco mensal sugerido: R$ ~2f~n", [Preco]),
    format("- Preco anual (com desconto se aplicado): R$ ~2f~n", [PrecoAnual]),
    format("- Add-ons sugeridos: ~w~n", [Addons]),
    format("~n[Entradas do usuario]~n"),
    format("- Telas simultaneas: ~w~n", [N]),
    format("- Quer 4K: ~w~n", [Alt]),
    format("- Sem anuncios: ~w~n", [NA]),
    format("- Prefere esportes: ~w~n", [Es]),
    format("- Conteudo infantil: ~w~n", [HK]),
    format("- Musica: ~w~n", [M]),
    format("- Estudante: ~w~n", [Stu]),
    format("- Orcamento: ~w~n", [Orc]).
