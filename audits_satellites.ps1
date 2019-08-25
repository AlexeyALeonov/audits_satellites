Param (
    $Path
)

if (-not $Path) {
    $logs = cmd.exe /c "docker logs storagenode 2>&1"
} else {
    $logs = Get-Content $Path
}

$audits = ($logs | Select-String GET_AUDIT).Line
$sats = (($audits | Select-String '({.*})').Matches.Value | ConvertFrom-Json).SatelliteID | Select-Object -Unique
 
foreach ($sat in $sats) {
   "Satellite:`t`t`t`t" + $sat
   "Unrecoverable Failed Audits:`t" + ($audits | Select-String failed | Select-String open | Select-String $sat).Count
   "Recoverable Failed Audits:`t" + ($audits | Select-String failed | Select-String open -NotMatch | Select-String $sat).Count
   "Successful Audits:`t`t" + ($audits | Select-String downloaded | Select-String $sat).Count
}
