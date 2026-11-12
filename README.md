# Evaluating Multi-Tenant Isolation Latency and Microarchitectural Overhead Trends on Constrained Edge Infrastructure

This repository contains the benchmarking suite, execution scripts, and empirical datasets supporting our research paper on consumer edge virtualization overheads.

## 📌 Research Overview
Traditional cloud benchmarks evaluate containers and virtual machines on uniform, enterprise-grade servers. This project isolates the **Kernel Boundary Tax** on legacy mobile/edge hardware (`Intel Core i3-2370M @ 2.40GHz`). Our empirical findings demonstrate that under thermally stabilized conditions, forcing context switches, Ring-0 memory remapping, and L1/L2 cache line invalidations introduces a **70.40% execution slowdown** compared to native execution pipelines.

## 🛠️ Repository Structure
* `benchmark.ps1` — The automated Windows PowerShell script executing 30 native baseline iterations and 30 memory-isolated iterations of a 100,000-loop floating-point workload.
* `results_summary.csv` — The aggregated statistical metrics harvested from the physical testbed.

## 📊 Empirical Results Summary

| Diagnostic Metric | Phase I: Native Baseline (Direct) | Phase II: Isolated Boundary (Context-Switched) | Architectural Delta |
| :--- | :--- | :--- | :--- |
| **Sample Size ($N$)** | 30 Runs | 30 Runs | — |
| **Workload Intensity** | 100,000 Float Loops | 100,000 Float Loops | — |
| **Mean Latency ($\mu$)** | `658.36 ms` | `1121.84 ms` | **+70.40% (Slowdown Tax)** |
| **Efficiency Index ($\alpha$)** | `1.000` | `0.587` | **-41.30% Efficiency Drop** |

## 🚀 How to Reproduce
1. Connect the host machine to AC wall power and set the Windows Power Plan to **High Performance**.
2. Close all background user-space applications to minimize OS thread scheduling noise.
3. Open **Windows PowerShell** as Administrator.
4. Execute the script:
   ```powershell
   .\benchmark.ps1
   ```
