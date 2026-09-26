# Monitoring - Azure Monitor, Metricas e Alertas

## Objetivo

Demonstrar observabilidade basica de uma VM no Azure - visualizacao de metricas, criacao de uma regra de alerta funcional, e consulta ao Log de Atividades.

## Metricas visualizadas

Metricas basicas de plataforma (gratuitas, sem configuracao adicional): Percentage CPU, disponibilidade da VM, trafego de rede. Foi feito um pico de stress de proposito para observar como a CPU reagiria e se apareceria alguma anomalia nos logs e metricas. A CPU saiu de 0,14% e chegou a 99,556% durante o teste, confirmando que a coleta de metricas estava funcionando corretamente em tempo real.

## Regra de alerta criada

| Item | Configuracao |
|---|---|
| Nome | alert-vm-cpu-alta |
| Escopo | vm-lab-linux |
| Condicao | Percentage CPU > 70 (media) |
| Acao | Grupo de acoes ag-cloudlab-email (notificacao por email) |
| Gravidade | 3 - Informativo |

## Teste e confirmacao do alerta

O alerta foi testado ativamente atraves da ferramenta `stress`, instalada na propria VM via SSH, simulando carga de CPU. Nas primeiras tentativas, o alerta por email nao foi disparado porque a CPU media na janela de avaliacao ficou abaixo dos 70% configurados como limite - a VM possuia 2 nucleos (ver licao abaixo), e as primeiras execucoes do stress nao foram longas o suficiente para sustentar a media acima do limite pelos 5 minutos da janela de avaliacao.

Apos um teste mais longo (400 segundos) com os 2 nucleos ocupados, o disparo foi confirmado no historico de alertas do Azure, mesmo sem o email chegar na caixa de entrada:

- 26/09/2026, 08:56 - Status: Novo, CPU: 77.944% - condicao atingida
- Resolvido automaticamente quando a CPU caiu abaixo do limite (18.928% pouco depois)

Esse comportamento (Novo -> Resolvido) e o esperado para alertas baseados em metricas: o Azure dispara quando a condicao e verdadeira e resolve automaticamente quando deixa de ser.

## Log de atividades

Consultado o Log de Atividades da VM, confirmando o registro de operacoes como reinicio e inicializacao da maquina (Start Virtual Machine, bem-sucedido) e eventos de atualizacao de integridade (Health Event Updated), demonstrando rastreabilidade de mudancas no recurso.

## Licoes aprendidas

**Tamanho de VM diferente do planejado**: a VM foi criada com o tamanho Standard_D2als_v6 (2 vCPUs, 4GB RAM) em vez do Standard_B1s planejado originalmente (1 vCPU, 1GB RAM), provavelmente por um erro de selecao durante a criacao. Isso gerou custo mais alto que o esperado e tambem exigiu ajuste no teste de carga (usar `stress --cpu 2` em vez de `--cpu 1`, ja que a VM tinha 2 nucleos). O numero maior de nucleos tambem contribuiu para o alerta nao disparar nas primeiras tentativas, ja que ocupar so 1 nucleo nao era suficiente para levar a media geral acima do limite configurado. Isso reforcou a importancia de conferir o tamanho exato da VM na tela de revisao antes de confirmar a criacao, nao so no momento da selecao inicial.

**Primeiras tentativas de disparo sem sucesso**: as primeiras execucoes do stress test (com duracao de 180-300 segundos) nao foram suficientes para disparar o alerta por email, ficando a media de CPU abaixo dos 70% configurados. O disparo so foi confirmado apos um teste mais longo (400 segundos), com a CPU sustentada acima de 70% por tempo suficiente para a media da janela completa ultrapassar o limite.

**Historico de alertas como fonte de verdade**: a confirmacao definitiva do disparo do alerta nao veio por email (que nao chegou na caixa de entrada nem no spam durante os testes), mas sim pela consulta direta ao historico de alertas no portal do Azure, onde o disparo (Novo) e a resolucao automatica (Resolvido) ficaram registrados. Isso reforcou que, ao investigar se um alerta funcionou, verificar o historico do proprio sistema e mais confiavel do que depender apenas de uma notificacao externa.

**Instabilidade de hardware durante o teste**: durante os testes desta fase, o monitor do computador utilizado apresentou falha (parou de funcionar), exigindo troca temporaria para uma TV como tela. Isso nao afetou a VM no Azure (que continuou rodando normalmente, independente da conexao local), reforcando na pratica que uma sessao SSH e um recurso cloud sao independentes do estado do computador cliente.
