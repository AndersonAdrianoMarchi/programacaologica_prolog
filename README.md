🧠 Sistema Especialista – Recomendador de Planos de Streaming

Disciplina: Linguagem de Programação e Paradigmas
Professor: Esp. Ademar Perfoll Junior
Curso: Sistemas de Informação
Trabalho 03 – Programação Lógica (Prolog)
Desenvolvido por: @Anderson_Marchi

🎯 Objetivo do Projeto

Este projeto implementa um sistema especialista em Prolog (SWI-Prolog) capaz de recomendar planos de streaming com base nas preferências e perfil do usuário.
O sistema faz inferências automáticas usando fatos e regras lógicas e fornece uma explicação detalhada das decisões tomadas (trilha das regras disparadas).

⚙️ Arquitetura do Projeto
/streaming_expert/
 ├── src/
 │   ├── main.pl       # menu e orquestração do fluxo principal
 │   ├── kb.pl         # base de conhecimento (planos, preços, domínios)
 │   ├── rules.pl      # regras de inferência e meta principal
 │   ├── ui.pl         # interação com o usuário (coleta de dados)
 │   ├── explain.pl    # explicação da trilha de raciocínio
 ├── README.md         # este arquivo

💻 Instalação
🔹 Requisitos:

SWI-Prolog 
Baixar em: https://www.swi-prolog.org/download/stable

🔹 Passos de instalação:

Clone o repositório (ou copie os arquivos):

git clone https://github.com/AndersonAdrianoMarchi/programacaologica_prolog.git

Inicie o SWI-Prolog:

swipl


Carregue o sistema:

?- ['main.pl'].


Execute o programa:

?- start.

🧩 Funcionamento

O sistema faz perguntas sobre:

número de telas simultâneas,

preferência por qualidade 4K,

presença de anúncios,

interesse em esportes,

existência de crianças,

música,

se o usuário é estudante,

e o nível de orçamento (baixo / médio / alto).

Com base nessas respostas, o sistema deduz automaticamente:

o plano mais adequado,

o preço mensal e anual (com desconto aplicado),

e os add-ons recomendados.

Ao final, exibe uma explicação com a trilha de regras acionadas.

🚀 Execução e Exemplo de Uso
🔸 Execução

Após rodar ?- start., o menu aparece:

=== Sistema Especialista - Recomendador de Planos de Streaming ===
Desenvolvido por: @Anderson_Marchi

1) Executar consulta
2) Sair
>


Escolha a opção 1 e responda às perguntas:

🔸 Exemplo de entrada
Pergunta	Resposta
Número de telas simultâneas	3
Prefere qualidade alta (4K)?	s
Prefere sem anúncios?	s
Tem interesse em esportes ao vivo?	s
Há crianças/necessidade de conteúdo infantil?	n
Deseja serviço de música junto?	n
Usuário é estudante (tem desconto)?	n
Qual é seu budget?	medio
🔸 Exemplo de saída (resumo do console)
[Explicacao]
- Regras disparadas (trilha): [needs_alta_resolucao, needs_sem_anuncios, rule_4k_medium, addon_sports]
- Plano recomendado: premium
- Preco mensal sugerido: R$ 29.90
- Preco anual (com desconto se aplicado): R$ 322.92
- Add-ons sugeridos: [sports]

[Entradas do usuario]
- Telas simultaneas: 3
- Quer 4K: sim
- Sem anuncios: sim
- Prefere esportes: sim
- Conteudo infantil: nao
- Musica: nao
- Estudante: nao
- Budget: medio

RESULTADO: resultado(plano(premium), preco_mensal(29.9), preco_anual(322.92), addons([sports]), motivos([...])).

🧠 Lógica e Inferência

O sistema utiliza:

8+ regras principais (rules.pl) para correlacionar necessidades com planos;

assert/retract para armazenar e limpar observações dinamicamente;

meta/1 como meta de inferência principal;

fired_rule/1 para rastrear as regras que contribuíram para o resultado;

Tratamento de incertezas, informando se há falta de dados.

🧾 Exemplo de Planos (Base de Conhecimento)
Plano	Telas	Qualidade	Preço (R$)	Descrição
lite	1	SD	5,90	Versão econômica, com anúncios
student	1	HD	6,90	Estudantes com desconto
basic	1	HD	9,90	1 tela, HD, com anúncios
standard	2	HD	19,90	2 telas, sem anúncios
premium	4	4K	29,90	4 telas, 4K
family	6	4K	24,90	6 telas, familiar

Add-ons disponíveis: sports, kids, music.
