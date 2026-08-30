# Solaris SPARC NVIDIA GPU Port Skeleton

Experimental scaffold for bringing modern NVIDIA acceleration to Oracle Solaris 11.4 on SPARC, with a render-only NVIDIA GPU and the existing AST framebuffer remaining the local console/display device.

## Primary target

```
Application / Proton / DXVK / Zink
              |
             NVK
              |
        libdrm_nouveau
              |
       /dev/dri/renderD128
              |
   Solaris modern DRM subset
              |
      Nouveau DRM frontend
              |
             NVKM
              |
       Solaris LinuxKPI/DDI
              |
         Tesla P4 / T4

Display/presentation path:
NVIDIA render -> offload/copy-present bridge -> Xorg -> Solaris AST -> VGA
```

The `upstream/gpu` directory is the user-supplied, already-pruned Linux `drivers/gpu` source snapshot. Keep it close to upstream. Put Solaris-specific glue in `solaris/` and small source deltas in `patches/`.

## Two NVIDIA kernel paths

* **P0 / recommended:** Nouveau + NVKM. C code, mature, supports Pascal P4 and Turing T4, and has existing big-endian handling in important paths.
* **Later:** Nova (`nova-core` + `nova-drm`). Clean GSP-first architecture for Turing+, Rust, intended to supersede Nouveau on GSP GPUs, but the supplied snapshot explicitly depends on `!CPU_BIG_ENDIAN` and is work-in-progress.

## Per-program GPU offload

The project includes an Optimus/PRIME-like design in `solaris/offload/` and `docs/OFFLOAD.md`.

The intended user experience is:

```sh
nvrun game
nvrun vulkaninfo
```

`nvrun` prefers Mesa's normal `DRI_PRIME` selection semantics. The display can remain on AST while selected applications render on the Tesla. Because the existing Solaris AST driver is a legacy framebuffer rather than a DRM PRIME device, the first implementation uses a copy-present bridge. A future AST DRM-lite bridge can enable more direct buffer sharing.

## Build status

This ZIP is a **skeleton, not a working driver**. The files under `solaris/` define the porting boundaries and TODOs. The intended implementation order is documented in `docs/MILESTONES.md`.

Start with:

```sh
make audit
make tree
./scripts/check-prereqs.sh
```
