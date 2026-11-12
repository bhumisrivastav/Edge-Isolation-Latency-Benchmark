<#
.SYNOPSIS
    Automated Microarchitectural Isolation Latency Benchmark
.DESCRIPTION
    Evaluates execution latency across 30 consecutive iterations of a 100,000-loop 
    floating-point workload to isolate hardware warmup dynamics vs. memory isolation boundaries.
.NOTES
    Hardware Baseline: Intel Core i3-2370M @ 2.40GHz
#>

# 1. Initialize Data Arrays & Parameters
$runs = 30
$iterations = 100000
$baselineResults = @()
$isolatedResults = @()

Write-Host "Starting Scientific Benchmark Suite ($runs Runs per Phase)..." -ForegroundColor Cyan

# 2. Phase I: Native Host Baseline Loop (Cold CPU State)
for ($i = 1; $i -le $runs; $i++) {
    $time = Measure-Command {
        for ($j = 1; $j -le $iterations; $j++) {
            $math = [Math]::Sqrt($j) * [Math]::Sin($j)
        }
    }
    $baselineResults += $time.TotalMilliseconds
    Write-Progress -Activity "Phase I: Running Native Host Workloads" -PercentComplete (($i/$runs)*100)
}

# 3. Phase II: Simulated Boundary Isolation (Forced GC & Cache Eviction)
for ($i = 1; $i -le $runs; $i++) {
    $time = Measure-Command {
        # Forces kernel memory-mapping reset and cache line invalidation
        [System.GC]::Collect() 
        [System.GC]::WaitForPendingFinalizers()
        for ($j = 1; $j -le $iterations; $j++) {
            $math = [Math]::Sqrt($j) * [Math]::Sin($j)
        }
    }
    $isolatedResults += $time.TotalMilliseconds
    Write-Progress -Activity "Phase II: Running Isolated Virtual Workloads" -PercentComplete (($i/$runs)*100)
}

# 4. Statistical Aggregation
$avgBaseline = ($baselineResults | Measure-Object -Average).Average
$avgIsolated = ($isolatedResults | Measure-Object -Average).Average
$boundaryTax = (($avgIsolated - $avgBaseline) / $avgBaseline) * 100
$alphaFactor = $avgBaseline / $avgIsolated

# 5. Output Academic Summary
Write-Host "`n==== RESEARCH EXPERIMENT DATA OVERVIEW ====" -ForegroundColor Green
Write-Host "Total Successful Samples Gathered : $runs"
Write-Host "Avg Native Baseline Latency      : [ $($avgBaseline.ToString('F5')) ms ]"
Write-Host "Avg Isolated Virtual Latency     : [ $($avgIsolated.ToString('F5')) ms ]"
Write-Host "Calculated Kernel Boundary Tax   : [ $($boundaryTax.ToString('F2'))% Slowdown ]"
Write-Host "Microarchitectural Accel. (Alpha): [ $($alphaFactor.ToString('F3')) ]"
Write-Host "==========================================" -ForegroundColor Green
