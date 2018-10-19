<#

.SYNOPSIS
A script for fetching lunchmenu for DEG16

.NOTES
Filename:   Get-Lunchmenu.ps1
Author:     Mads Moi-Aune <mads@moiaune.no>

.PARAMETER All
Will fetch the menu for the whole week

.EXAMPLE
./Get-Lunchmenu -All

.EXAMPLE
./Get-Lunchmenu

.LINK
Github repo: https://github.com/madsaune/ps-deg16-lunchmenu

#>

Param(
    [Switch] $All
)

$html = Invoke-WebRequest -Method get -Uri https://www.braatheneiendom.no/NO/Eiendommer/DEG16/Kjokkenet/

$menus = $html.ParsedHtml.getElementsByTagName('div') | Where-Object { $_.className -eq 'caption-body' }

ForEach ($menu in $menus) {
    $elms = $menu.childNodes;

    If(-not($All)) {
        $date = Get-Date -Format "D"

        If(-not($elms[1].innerText.trim().toLower() -eq $date)) {
            Continue
        }
    }

    $props = [ordered]@{
        "Day" = $elms[1].innerText.trim();
        "Main" = $elms[2].innerText.trim();
        "Vegetarian" = $elms[3].innerText.trim();
        "Soup" = $elms[4].innerText.trim();
    }

    New-Object -TypeName PSObject -Prop $props
}