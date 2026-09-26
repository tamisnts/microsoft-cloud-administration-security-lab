# Security - VM Temporaria e Acesso Remoto

## Abordagem de seguranca

Este laboratorio nunca cria deliberadamente uma configuracao insegura em um recurso real apenas para demonstrar uma correcao depois. Toda configuracao de acesso foi feita restrita desde o primeiro momento (ver docs/networking.md para o raciocinio completo da regra NSG).

## VM temporaria criada

| Item | Configuracao |
|---|---|
| Nome | vm-lab-linux |
| Sistema operacional | Ubuntu Server 22.04 LTS |
| Tamanho | Standard_B1s (mais barato, 1 vCPU / 1GB RAM) |
| Disco | Standard HDD |
| Autenticacao | Chave SSH (nao senha) |
| Rede | vnet-cloudlab / snet-vm |
| NSG | nsg-vm, com acesso restrito ao IP pessoal na porta 22 |
| Auto-shutdown | Habilitado, horario de seguranca configurado |

## Acesso remoto via SSH

O acesso foi testado e validado via PowerShell local, usando a chave privada baixada no momento da criacao da VM. Comando usado: ssh -i .\nome-da-chave.pem usuario@IP_PUBLICO

Conexao confirmada com sucesso, validando ao mesmo tempo: a regra do NSG (permitindo so o IP pessoal), a autenticacao por chave SSH, e a conectividade da VM dentro da VNet/Subnet configurada.

## Licoes aprendidas

**Regra de NSG com origem e destino invertidos**: no meio do processo de criacao da regra de seguranca (documentado tambem em docs/networking.md), inverti sem querer os campos de origem e destino - a configuracao ficou permitindo que qualquer IP da internet se conectasse na porta 22, desde que o destino fosse o meu IP pessoal, quando na verdade o destino deveria ser a VM. Corrigi apos revisar a tabela de regras e comparar visualmente com o que era esperado.

**Acesso remoto via PowerShell usando chave SSH**: aprendi na pratica como usar o comando ssh -i no PowerShell do Windows para autenticar em uma VM Linux usando uma chave privada, em vez de senha - incluindo a necessidade de referenciar o caminho correto do arquivo de chave.

**Erro de digitacao no nome do arquivo (hifen vs underline)**: tentei conectar usando um nome de arquivo com hifen (vm-lab-linux-key.pem), mas o arquivo real havia sido salvo pelo Azure com underline (vm-lab-linux_key.pem). O SSH retornou "Identity file not accessible: No such file or directory", o que me levou a verificar o nome exato do arquivo com o comando dir antes de tentar novamente.

**Permissoes de arquivo no Windows para chave SSH**: apos corrigir o nome do arquivo, o SSH ainda recusou a conexao com o erro "Bad permissions... UNPROTECTED PRIVATE KEY FILE". Isso acontece porque o SSH exige que a chave privada nao seja acessivel por outros usuarios do sistema. Resolvi usando o comando icacls do Windows para remover heranca de permissoes e conceder acesso de leitura apenas ao meu proprio usuario, com os comandos: icacls .\arquivo.pem /inheritance:r e depois icacls .\arquivo.pem /grant:r "usuario:(R)"

Essa sequencia de erros e correcoes (nome de arquivo, depois permissoes) reforcou a importancia de ler as mensagens de erro do terminal com atencao - cada uma apontava exatamente qual era o proximo obstaculo a resolver.
