# Nova vs Nouveau/NVKM

## What Nova improves

Nova is a clean-slate, GSP-first NVIDIA kernel architecture for Turing and newer GPUs. Its main advantages over Nouveau/NVKM are architectural rather than immediate performance guarantees:

1. **GSP-first design.** Modern NVIDIA GPUs move a large amount of privileged GPU management into NVIDIA's signed GSP firmware. Nova is designed around that reality instead of carrying decades of pre-GSP paths.
2. **Smaller legacy burden.** Nouveau/NVKM supports very old NVIDIA generations. Nova can focus on Turing+ and avoid much of the NV04-through-Pascal compatibility machinery.
3. **Layered core design.** `nova-core` abstracts hardware and firmware, while second-level drivers such as `nova-drm` and future VFIO/vGPU users sit above it. This is attractive for Solaris because the core can in principle be paired with a Solaris-specific second-level interface.
4. **Firmware-version abstraction.** GSP-RM interfaces change between firmware releases. Nova explicitly aims to hide those version differences behind a stable core API.
5. **Rust memory-safety advantages.** Rust can reduce common kernel memory lifetime and ownership bugs, especially in a new driver with complex asynchronous firmware interaction.
6. **Better long-term fit for new NVIDIA hardware.** Nova is intended upstream to supersede Nouveau on GSP-based GPUs, so new architectural work should increasingly land there.
7. **Natural vGPU/VFIO reuse.** A hardware/firmware core not welded to DRM can support non-graphics consumers more cleanly.

## Why Nouveau is still P0 for Solaris/SPARC

The supplied snapshot says `nova-core` and `drm/nova` depend on `RUST` and `!CPU_BIG_ENDIAN`, and both are explicitly marked work-in-progress. Nouveau is C, already handles a much wider range of GPUs, includes Pascal P4, and has real big-endian-aware code paths.

Therefore:

* P4 -> Nouveau/NVKM only.
* T4 -> Nouveau/NVKM first; Nova later.
* A2/newer -> Nova becomes increasingly attractive once the Solaris Rust/big-endian blockers are solved.

Nova does **not** remove the need for a userspace-facing graphics API. `nova-core` is the low-level core; `nova-drm` or a Solaris equivalent still has to expose memory, VM, synchronization, submission, and render-node operations to NVK.
