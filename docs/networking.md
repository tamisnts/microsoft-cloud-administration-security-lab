# Networking - VNet, Subnet e NSG

## Objetivo

Criar a estrutura de rede que vai hospedar a VM temporaria do laboratorio, com controle de acesso restrito desde a criacao - sem expor portas abertas para a internet em nenhum momento.

## Recursos criados

| Recurso | Nome | Configuracao |
|---|---|---|
| Virtual Network | vnet-cloudlab | Espaco de enderecos 10.0.0.0/16, regiao Brazil South |
| Subnet | snet-vm | Dentro da vnet-cloudlab, associada ao NSG |
| Network Security Group | nsg-vm | Associado a subnet snet-vm |

## Regra de seguranca criada

| Prioridade | Nome | Porta | Protocolo | Origem | Destino | Acao |
|---|---|---|---|---|---|---|
| 100 | Allow-SSH-MeuIP | 22 | TCP | 177.XXX.XXX.XXX/32 (IP pessoal) | Qualquer | Permitir |

Nota: o IP completo foi omitido desta documentacao publica por ser dado pessoal. O principio aplicado foi restringir a origem a um unico IP (/32), nunca a um intervalo amplo nem a "qualquer origem".

## Decisao de seguranca

Optou-se por nao criar nenhuma regra permissiva (tipo 0.0.0.0/0) na VM real do laboratorio, mesmo que temporariamente, para evitar exposicao desnecessaria - mesmo em um ambiente de estudos sem dados sensiveis. O acesso SSH foi restrito desde a primeira regra criada, seguindo o principio de menor privilegio tambem na camada de rede.

## Servicos de seguranca pagos avaliados e descartados

Durante a criacao da VNet, o Azure ofereceu servicos adicionais pagos (Azure Bastion, Firewall do Azure, Protecao DDoS, Criptografia de rede virtual). Nenhum foi habilitado, pois o NSG com regra restrita por IP ja atende ao objetivo do laboratorio sem gerar custo adicional.

## Licoes aprendidas

No meio do processo de criacao da regra de seguranca, inverti sem querer os campos de origem e destino - a configuracao ficou permitindo que qualquer IP da internet se conectasse na porta 22, desde que o destino fosse o meu IP pessoal, quando na verdade o destino deveria ser a VM (ou "qualquer", representando a rede interna) e a origem deveria ser o meu IP.

Percebi o erro ao revisar a tabela de regras apos a criacao, comparando visualmente as colunas Origem e Destino com o que era esperado. Corrigi editando a regra diretamente, ajustando primeiro a Origem para o IP correto e depois o Destino de volta para "Qualquer".

Essa experiencia reforcou a importancia de sempre revisar a tabela de regras depois de cria-las, e nao assumir que o preenchimento do formulario necessariamente resultou na configuracao pretendida - um erro de UI/preenchimento pode gerar uma regra de seguranca com efeito oposto ao desejado.
