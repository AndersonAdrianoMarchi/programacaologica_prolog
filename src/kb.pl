% kb.pl
% Base de conhecimento: preços base (mensal) e descrições dos planos
% Valores fictícios para exemplo - ajuste conforme desejar

% plano(Nome, PrecoMensal, max_streams, qualidade, descricao).
plano(basico,  9.90, 1, hd,    'Acesso basico, 1 tela, sem 4K, com anuncios opcionais.').
plano(padrao, 19.90, 2, hd,  '2 telas simultaneas, HD sem 4K, sem anuncios.').
plano(premium, 29.90, 4, '4k', '4 telas, suporte 4K, ideal para familias.').
plano(familia, 24.90, 6, '4k',  'Plano familiar 6 telas, 4K, recomendado para familias grandes.').
plano(estudante, 6.90, 1, hd,   'Desconto para estudantes, 1 tela, HD com anuncios reduzidos.').
plano(lite, 5.90, 1, sd,      'Versao economica, apenas definicao SD, com anuncios.').

% Add-ons
addon(esportes, 9.90, 'Canal esportivo ao vivo').
addon(kids, 4.90, 'Conteudo infantil adicional').
addon(musica, 7.90, 'Servico de musica em streaming').

% Dominios de preferencia para facil validação
qualidade_valida(sd).
qualidade_valida(hd).
qualidade_valida('4k').

% desconto anual (percentual) para assinatura anual
desconto_anual(10).  % 10%
