# RBAC - Controle de Acesso Baseado em Funcoes

## Objetivo

Demonstrar atribuicao de permissoes no Azure seguindo o principio do menor privilegio, usando grupos do Microsoft Entra ID em vez de atribuicoes individuais.

## Estrutura

Todas as atribuicoes foram feitas no escopo do Resource Group `rg-cloudlab-tami`, nunca na subscription inteira - isso limita o alcance de qualquer permissao concedida.

## Atribuicoes realizadas

| Identidade | Tipo | Papel (Role) | Escopo | Justificativa |
|---|---|---|---|---|
| GRP-TI-Suporte | Grupo de seguranca | Reader | rg-cloudlab-tami | Equipe de suporte precisa visualizar recursos para diagnostico, mas nao deve alterar configuracoes |
| GRP-Admin-Lab | Grupo de seguranca | Contributor | rg-cloudlab-tami | Administracao do laboratorio precisa criar/editar recursos, mas nao deve gerenciar acesso de outras pessoas |
| Tamires Santana | Usuario | Owner | Subscription (herdado) | Dona da assinatura - controle total necessario para gerenciamento geral |

## Sobre as funcoes escolhidas

**Reader**: permite apenas visualizar recursos existentes, sem poder criar, editar ou excluir nada. Ideal para quem precisa monitorar ou dar suporte sem risco de alterar configuracoes por engano.

**Contributor**: permite criar, editar e excluir a maioria dos recursos dentro do escopo atribuido, mas nao permite gerenciar quem tem acesso (nao pode adicionar/remover pessoas nem atribuir novas funcoes). Essa e a diferenca chave em relacao ao Owner.

**Owner**: acesso total, incluindo gerenciamento de acesso de outras pessoas. Reservado apenas para quem administra a assinatura como um todo.

## Verificacao realizada

Comando usado para confirmar as atribuicoes (via Azure Cloud Shell/PowerShell): 



Resultado confirmado: cada grupo com exatamente o papel esperado, sem duplicatas nem atribuicoes excedentes.

## Coisas que aprendi no Azure

O Azure permite criar dois grupos com o mesmo nome - cometi esse erro sem perceber, criando dois grupos distintos (com IDs diferentes) mas ambos chamados GRP-TI-SUPORTE, enquanto o grupo GRP-Admin-Lab nao chegou a ser criado corretamente.

Percebi o problema ao tentar atribuir a funcao (role) para o grupo administrador e nao encontrar a opcao certa na interface do portal. Em vez de continuar tentando pela interface, usei o Azure Cloud Shell (PowerShell) para investigar de verdade: listei todos os grupos existentes com `Get-AzADGroup`, verifiquei os membros de cada um com `Get-AzADGroupMember` usando o ObjectId de cada grupo, e identifiquei qual grupo tinha qual membro.

Com isso descobri que um dos grupos duplicados na verdade continha o membro certo do administrador, so que com o nome errado. Em vez de apagar e recriar, renomeei esse grupo via PowerShell com `Update-AzADGroup`, e depois atribui a funcao Contributor a ele tambem via PowerShell, usando `New-AzRoleAssignment` com o ObjectId direto - o que acabou sendo mais confiavel do que tentar encontrar a funcao certa em uma lista enorme de opcoes na interface grafica.

Essa experiencia reforcou a importancia de verificar recursos por ID (nao so por nome) ao administrar identidade em escala, e mostrou na pratica por que PowerShell costuma ser mais preciso que a interface grafica para tarefas administrativas.
