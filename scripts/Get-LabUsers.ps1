<#
.SYNOPSIS
    Lista todos os usuarios do laboratorio no Microsoft Entra ID.
.DESCRIPTION
    Script simples para consulta administrativa de usuarios, mostrando nome de exibicao,
    UPN (User Principal Name) e status de habilitacao da conta.
.PREREQUISITOS
    Modulo Az instalado, e sessao autenticada via Connect-AzAccount.
.EXEMPLO
    .\Get-LabUsers.ps1
#>

Connect-AzAccount

Get-AzADUser | Select-Object DisplayName, UserPrincipalName, AccountEnabled | Format-Table -AutoSize