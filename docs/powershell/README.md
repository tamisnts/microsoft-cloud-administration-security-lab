# PowerShell - Scripts de Administracao

## Objetivo

Demonstrar automacao basica de tarefas administrativas com PowerShell, usando o modulo Az para consultar recursos do Microsoft Entra ID e do Azure.

## Scripts criados

| Script | Objetivo |
|---|---|
| Get-LabUsers.ps1 | Lista usuarios do Entra ID (nome, UPN, status) |
| Get-LabGroups.ps1 | Lista grupos de seguranca e seus membros |
| Export-LabResourceReport.ps1 | Gera relatorio de recursos do Resource Group, incluindo tags |

## Pre-requisitos

Modulo Az instalado (`Install-Module -Name Az -Scope CurrentUser`) e sessao autenticada via `Connect-AzAccount`. Os scripts tambem podem ser executados diretamente no Azure Cloud Shell, que ja vem com o modulo pre-instalado e autenticado automaticamente.

## Testes realizados

Todos os tres scripts foram testados via Azure Cloud Shell:

**Get-LabUsers.ps1**: retornou corretamente os 4 usuarios do tenant (3 fictos de laboratorio + a conta principal), com nome de exibicao, UPN e status de habilitacao.

**Get-LabGroups.ps1**: retornou corretamente os 2 grupos de seguranca (GRP-Admin-Lab e GRP-TI-SUPORTE) e seus respectivos membros, confirmando a estrutura de RBAC documentada em docs/rbac.md.

**Export-LabResourceReport.ps1**: executado apos a limpeza dos recursos de VM (Fases 4/5), retornou corretamente uma lista vazia, confirmando que o Resource Group nao possui recursos ativos no momento - resultado esperado e correto, dado o contexto do laboratorio naquele momento (governanca de custos ativa).

## Licoes aprendidas

**Modulo Az nao instalado localmente**: ao tentar rodar os scripts no PowerShell local do Windows, os comandos Connect-AzAccount e Get-AzResource nao foram reconhecidos, pois o modulo Az nao estava instalado nessa maquina (apenas usado ate entao via Cloud Shell, que ja vem pre-configurado). Os testes foram realizados via Cloud Shell como alternativa pratica, mantendo os arquivos de script salvos localmente no repositorio.

**Import de modulo especifico no Cloud Shell**: em um momento pontual, o comando Get-AzResourceGroup nao foi reconhecido mesmo no Cloud Shell, sendo necessario carregar o modulo explicitamente com Import-Module Az.Resources antes de rodar o comando - uma licao sobre como modulos do PowerShell podem nao estar totalmente carregados em uma sessao, mesmo em ambientes pre-configurados.
