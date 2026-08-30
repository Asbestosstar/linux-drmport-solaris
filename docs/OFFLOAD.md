# PRIME/Optimus-like render offload on Solaris

## Goal

Keep the T8's existing AST framebuffer as the boot console and Xorg scanout device while allowing individual applications to render on an NVIDIA P4/T4 with NVK.

```
                    DISPLAY PROVIDER
Xorg desktop -> Solaris AST driver -> VGA 1024x768

                    RENDER PROVIDER
selected app -> NVK -> Nouveau -> Tesla P4/T4
                         |
                         +---- completed image ----+
                                                   |
                                      present/offload bridge
                                                   |
                                                   v
                                              Xorg / AST
```

## Application selection

Prefer compatibility with Mesa's normal per-process selection mechanism:

```sh
DRI_PRIME=1 application
```

The included `bin/nvrun` wrapper does this. It also sets a Solaris-specific hint (`SOLARIS_RENDER_OFFLOAD=1`) for the future WSI/presentation bridge. `nvrun --isolate` uses the Mesa `DRI_PRIME=...!` form so Vulkan exposes only the selected render GPU, which is useful for DXVK/Proton.

A later implementation can support explicit PCI selectors such as:

```sh
DRI_PRIME=pci-0000_03_00_0 application
```

## Phase A: copy-present bridge

The existing Solaris `ast` driver is a legacy framebuffer, not a DRM PRIME importer. Therefore P0 does not require AST to understand dma-buf.

1. NVK renders into NVIDIA VRAM.
2. NVIDIA copy engine transfers/packs the image into a pinned host-visible staging allocation.
3. The Solaris offload WSI/X11 bridge presents/copies that image into the Xorg drawable owned by AST.
4. Fences/syncobjs prevent CPU/GPU races.

At 1024x768x32bpp a full frame is only about 3 MiB, so correctness and synchronization are a higher priority than zero-copy for P0.

## Phase B: PRIME-like shared-buffer API

Implement a Solaris-neutral buffer object export/import handle in `drm_solaris_prime.c`. Preserve Linux DRM PRIME semantics where practical, but do not require Linux dma-buf internals.

## Phase C: optional AST DRM-lite bridge

A small DRM/KMS compatibility wrapper around AST could make AST a real display provider and allow more standard DRI3/Present/PRIME integration. This is optional and should come after NVK rendering works.

## Provider policy

* AST is the default display provider.
* Software/default Mesa remains available for ordinary desktop applications.
* `nvrun`/`DRI_PRIME` selects NVIDIA for a process.
* The NVIDIA driver is render-only initially; it does not own a CRTC/connector and does not need FCode.
