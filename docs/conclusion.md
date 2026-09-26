# Conclusao

## O que foi implementado na pratica

- Estrutura de identidade no Microsoft Entra ID: usuarios ficticios, grupos de seguranca, e atribuicoes RBAC seguindo o principio do menor privilegio
- Rede segura: VNet, Subnet e NSG com regra de acesso restrita a um unico IP, nunca exposta amplamente a internet
- VM Linux temporaria, criada, acessada via SSH com autenticacao por chave, monitorada e excluida ao final do uso
- Regra de alerta funcional no Azure Monitor, testada ativamente com carga de CPU e confirmada no historico de disparos
- Duas politicas de governanca no Azure Policy (localizacao permitida e tag obrigatoria)
- Tres scripts PowerShell para consulta de usuarios, grupos e relatorio de recursos, testados via Azure Cloud Shell

## O que foi estudado/documentado conceitualmente

Microsoft 365 (Exchange Online, Teams, SharePoint, OneDrive) e Microsoft Intune foram estudados a partir da documentacao oficial da Microsoft, sem implementacao pratica, devido a ausencia de um tenant com licenciamento adequado para essas ferramentas.

## Limitacoes

- Ausencia de tenant Microsoft 365 licenciado limitou a pratica em Exchange, Teams, SharePoint, OneDrive e Intune a nivel conceitual
- Modulo Az do PowerShell nao instalado no ambiente local, contornado com o uso do Azure Cloud Shell
- Um incidente de exclusao acidental do Resource Group completo durante a limpeza de recursos, exigindo recriacao parcial do ambiente

## Aprendizados principais

Alem dos conceitos tecnicos de cada tecnologia (identidade, rede, computacao, monitoramento, governanca, automacao), este laboratorio reforcou habilidades praticas de administracao de cloud que vao alem de "seguir um tutorial":

- Diagnostico de problemas reais: grupos duplicados no Entra ID, regras de NSG com origem/destino invertidos, erros de permissao de arquivo no Windows para chaves SSH, e um tamanho de VM diferente do planejado
- Uso de PowerShell/Cloud Shell como ferramenta de investigacao quando a interface grafica do portal nao era suficiente ou clara
- Importancia de verificar o escopo exato de uma acao destrutiva (como excluir um Resource Group) antes de confirma-la
- Disciplina de controle de custos: criar recursos apenas quando necessarios, e remove-los assim que a demonstracao de cada fase era concluida

## Proximos passos (fora do escopo deste laboratorio)

Caso surja acesso a um tenant Microsoft 365 licenciado no futuro (por exemplo, atraves de um programa educacional ou profissional), os itens documentados conceitualmente em docs/microsoft365.md e docs/intune.md poderiam ser revisitados e implementados na pratica.
