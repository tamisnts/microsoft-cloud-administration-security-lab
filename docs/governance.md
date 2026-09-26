# Governance - Resource Groups, Tags e Azure Policy

## Objetivo

Demonstrar praticas de governanca de cloud - organizacao por Resource Group, uso de tags, controle de custos, e aplicacao de politicas automatizadas de conformidade.

## Resource Group

| Item | Valor |
|---|---|
| Nome | rg-cloudlab-tami |
| Regiao | Brazil South |
| Tags | projeto=cloudlab, ambiente=estudo, owner=tami |

Todos os recursos do laboratorio foram organizados dentro de um unico Resource Group, facilitando tanto a governanca (visualizacao centralizada) quanto a limpeza (exclusao em massa ao final de cada fase).

## Politicas do Azure aplicadas

| Politica | Escopo | Objetivo |
|---|---|---|
| Allowed locations | rg-cloudlab-tami | Garante que recursos so possam ser criados na regiao Brazil South, evitando custos ou latencia de regioes nao planejadas |
| Require a tag on resources | rg-cloudlab-tami | Audita se recursos futuros possuem a tag "projeto", reforcando o habito de organizacao por tags estabelecido desde o inicio do laboratorio |

Ambas as politicas sao gratuitas (politicas built-in do Azure Policy nao geram custo) e funcionam independente de haver recursos ativos no momento - o escopo (Resource Group) e o que importa, nao os recursos que existem dentro dele.

## Controle de custos praticado

Ao longo do laboratorio, o principio aplicado foi: criar recursos apenas quando necessarios para demonstrar uma fase especifica, e exclui-los assim que a demonstracao fosse concluida - especialmente a VM, que gera custo por hora enquanto ligada e por dia mesmo desligada (disco).

## Licoes aprendidas

**Exclusao acidental do Resource Group inteiro**: durante a limpeza da VM (Fase 4/5), o Resource Group rg-cloudlab-tami foi excluido por engano junto com os recursos que deveriam ser removidos, levando junto tambem a VNet e o NSG que ainda seriam utilizados. Isso exigiu recriar o Resource Group do zero para continuar o laboratorio.

Essa experiencia reforcou uma licao importante de governanca: ao excluir recursos no Azure, e fundamental confirmar exatamente o escopo da exclusao (um recurso especifico vs. o Resource Group inteiro) antes de confirmar a acao, ja que a exclusao de um Resource Group remove tudo dentro dele de uma vez, sem distincao entre o que deveria ou nao ser mantido. Documentacao previa (como os arquivos deste repositorio) foi o que permitiu recuperar o contexto e recriar rapidamente apenas o necessario, sem perda de conhecimento sobre o que havia sido configurado.
