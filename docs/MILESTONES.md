# Milestones

## P0 - hardware bring-up

- [ ] Solaris SPARCV9 module loads
- [ ] Bind exact P4 PCI ID only during early development
- [ ] PCI config access
- [ ] BAR0/BAR1 mapping
- [ ] endian-safe MMIO helpers
- [ ] identify chipset through NVKM
- [ ] fixed/MSI/MSI-X interrupt path
- [ ] DMA allocation and cookie translation
- [ ] firmware loading
- [ ] VRAM detection and basic GPU initialization

## P1 - render-node DRM

- [ ] `/dev/dri/renderD128`
- [ ] DRM version/capability ioctls
- [ ] GEM handle lifecycle
- [ ] mmap/devmap BOs
- [ ] TTM minimum viable VRAM/system placement
- [ ] dma_fence/dma_resv compatibility
- [ ] syncobj + timeline syncobj
- [ ] DRM scheduler/exec
- [ ] GPUVM
- [ ] Nouveau VM_INIT / VM_BIND / EXEC
- [ ] command submission + signaled fence

## P2 - userspace

- [ ] build Solaris SPARC `libdrm_nouveau`
- [ ] Mesa/NVK detects render node
- [ ] `vulkaninfo`
- [ ] Vulkan compute
- [ ] offscreen triangle

## P3 - per-program offload/presentation

- [ ] `DRI_PRIME=1` selects NVIDIA
- [ ] copy-present staging path
- [ ] X11/WSI presentation to AST
- [ ] `nvrun` wrapper
- [ ] synchronization without tearing/corruption

## P4

- [ ] Zink/OpenGL
- [ ] DXVK
- [ ] VKD3D-Proton
- [ ] Proton game

## P5 - optional

- [ ] PRIME-like shared-buffer path
- [ ] AST DRM-lite display provider
- [ ] T4 Nova experiment
- [ ] Rust-for-Solaris kernel support
- [ ] Nova big-endian audit
