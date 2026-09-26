<#
.SYNOPSIS
    Gera um relatorio CSV dos recursos do Resource Group do laboratorio, incluindo tags.
.DESCRIPTION
    Script de apoio a governanca - lista todos os recursos de um Resource Group,
    seu tipo, localizacao e tags associadas, exportando para um arquivo CSV.
    Util para verificar rapidamente se os recursos seguem a convencao de tags
    estabelecida no projeto (projeto, ambiente, owner).
.PREREQUISITOS
    Modulo Az instalado, e sessao autenticada via Connect-AzAccount.
.EXEMPLO
    .\Export-LabResourceReport.ps1
#>

Connect-AzAccount

$resourceGroupName = "rg-cloudlab-tami"
$outputPath = ".\relatorio-recursos.csv"

$recursos = Get-AzResource -ResourceGroupName $resourceGroupName

$relatorio = $recursos | Select-Object Name, ResourceType, Location, @{
    Name = "Tags"
    Expression = { ($_.Tags.GetEnumerator() | ForEach-Object { "$($_.Key)=$($_.Value)" }) -join "; " }
}

$relatorio | Export-Csv -Path $outputPath -NoTypeInformation -Encoding UTF8

Write-Host "Relatorio gerado em: $outputPath" -ForegroundColor Green
$relatorio | Format-Table -AutoSize