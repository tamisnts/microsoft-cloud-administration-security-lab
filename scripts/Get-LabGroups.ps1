<#
.SYNOPSIS
    Lista os grupos de seguranca do laboratorio e seus membros.
.DESCRIPTION
    Script para consulta administrativa de grupos, exibindo o nome de cada grupo
    seguido dos membros associados a ele.
.PREREQUISITOS
    Modulo Az instalado, e sessao autenticada via Connect-AzAccount.
.EXEMPLO
    .\Get-LabGroups.ps1
#>

Connect-AzAccount

$grupos = Get-AzADGroup

foreach ($grupo in $grupos) {
    Write-Host "Grupo: $($grupo.DisplayName)" -ForegroundColor Cyan
    Get-AzADGroupMember -GroupObjectId $grupo.Id | Select-Object DisplayName, Id | Format-Table -AutoSize
}
