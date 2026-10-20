
# =====================
#    PROCESSOS PARE
# =====================

$processos = Get-Process

foreach ($proc in $processos) {

    Write-Host ""
    Write-Host "=============== $($proc.ProcessName) ($($proc.Id)) ==============="
    Write-Host ""

    $threads = $proc.Threads

    Write-Host "Total threads: $($threads.Count)"
    Write-Host ""

    foreach ($thread in $threads) {
        Write-Host "ID: $($thread.Id) CPU TIME: $($thread.TotalProcessorTime)"
    }
}
