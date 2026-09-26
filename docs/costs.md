# Costs - Controle de Custos do Laboratorio

## Abordagem geral

Este laboratorio foi conduzido priorizando recursos gratuitos ou de baixissimo custo, com criacao de recursos pagos apenas quando estritamente necessario para demonstrar uma fase especifica, seguidos de exclusao imediata apos a demonstracao.

## Recursos gratuitos utilizados (sem custo)

- Resource Groups e Tags
- Microsoft Entra ID (tier gratuito): usuarios, grupos, RBAC
- Virtual Network, Subnet e Network Security Group
- Azure Policy (politicas built-in)
- Metricas basicas de plataforma (CPU, disponibilidade)
- PowerShell / Azure Cloud Shell

## Recursos com custo (temporarios)

| Recurso | Custo estimado | Duracao | Status final |
|---|---|---|---|
| VM (Standard_D2als_v6, 2 vCPUs) | Superior ao planejado - tamanho maior que o Standard_B1s original | Algumas horas, durante Fases 4 e 5 | Excluida |
| Disco da VM (Standard HDD) | Poucos centavos/dia enquanto existiu | Mesmo periodo da VM | Excluido |
| IP publico (dinamico) | Baixo custo | Mesmo periodo da VM | Excluido |
| Regra de alerta (Azure Monitor) | Aproximadamente $0.10 (conforme exibido no portal) | Enquanto a regra existir | Mantida (custo minimo, nao critico) |

## Incidente de custo

A VM foi criada com o tamanho Standard_D2als_v6 (2 vCPUs, 4GB RAM) em vez do Standard_B1s planejado (1 vCPU, 1GB RAM), resultando em um custo por hora mais alto que o esperado. Esse erro foi identificado durante a Fase 5, ao verificar o campo "Tamanho" da VM no portal. A decisao tomada foi concluir os testes necessarios rapidamente e excluir a VM, em vez de recriar imediatamente com o tamanho correto, equilibrando o tempo de correcao com o impacto financeiro real (baixo, dado o volume de creditos disponiveis).

## Procedimento de limpeza aplicado

Ao final das Fases 4 e 5, os seguintes recursos foram excluidos: VM, disco do sistema operacional, IP publico e interface de rede associada (configurado para exclusao automatica junto com a VM).

Durante esse processo, o Resource Group inteiro (rg-cloudlab-tami) foi excluido acidentalmente, levando junto tambem a VNet e o NSG que ainda seriam utilizados (ver detalhes em docs/governance.md). O Resource Group foi recriado para dar continuidade ao laboratorio.

## Verificacao de custos

O painel de Cost Management do Azure foi consultado periodicamente ao longo do laboratorio para confirmar que os custos incorridos permaneciam proximos de zero, dado o volume de creditos disponiveis via Azure for Students.
