Param (
    $Path
)

if (-not $Path) {
    $logs = cmd.exe /c "docker logs storagenode 2>&1"
} else {
    $logs = Get-Content $Path
}

$audits = ($logs | sls GET_AUDIT).Line
$sats = (($audits | sls '({.*})').Matches.Value | ConvertFrom-Json).SatelliteID | select -Unique
 
foreach ($sat in $sats) {
   "Satellite:`t`t`t`t" + $sat
   "Unrecoverable Failed Audits:`t" + ($audits | sls failed | sls open | sls $sat).Count
   "Recoverable Failed Audits:`t" + ($audits | sls failed | sls open -NotMatch | sls $sat).Count
   "Successful Audits:`t`t" + ($audits | sls downloaded | sls $sat).Count
}
