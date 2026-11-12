# Evaluating Multi-Tenant Isolation Latency and Microarchitectural Warmup Trends on Constrained Edge Infrastructure

This repository contains the benchmarking suite, execution scripts, and empirical datasets supporting our research paper on consumer edge virtualization overheads.

## 📌 Research Overview
Traditional cloud benchmarks evaluate containers and virtual machines on uniform, enterprise-grade servers. This project isolates the **Kernel Boundary Tax** on legacy mobile/edge hardware (`Intel Core i3-2370M @ 2.40GHz`). Our findings demonstrate that dynamic hardware power scaling and warm CPU cache states can exert a stronger influence on execution latency than logical software isolation boundaries.

## 🛠️ Repository Structure
* `benchmark.ps1` — The automated Windows PowerShell script executing 30 cold-baseline iterations and 30 memory-isolated iterations of a 100,000-loop transcendental math workload.
* `results_summary.csv` — The aggregated statistical metrics harvested from the physical testbed.

## 📊 Empirical Results Summary

| Diagnostic Metric | Phase I: Native Baseline (Cold) | Phase II: Isolated Boundary (Warm) | Architectural Delta |
| :--- | :--- | :--- | :--- |
| **Sample Size ($N$)** | 30 Runs | 30 Runs | — |
| **Mean Latency ($\mu$)** | `1463.99 ms` | `950.32 ms` | **-35.09% (Acceleration)** |
| **Acceleration Factor ($\alpha$)** | `1.000` | `1.540` | **+54.05% Efficiency** |

## 🚀 How to Reproduce
1. Connect the host machine to AC wall power and set the Windows Power Plan to **High Performance**.
2. Close all background user-space applications to minimize OS thread scheduling noise.
3. Open **Windows PowerShell** as Administrator.
4. Execute the script:
   ```powershell
   .\benchmark.ps1
   ```
