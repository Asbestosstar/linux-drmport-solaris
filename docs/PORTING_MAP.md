# Solaris porting map

The objective is to avoid rewriting Nouveau/NVKM. Implement Linux-compatible interfaces at the OS boundary and keep GPU-specific code close to upstream.

| Linux subsystem/API | Solaris target | Skeleton location |
|---|---|---|
| PCI `struct pci_dev`, BARs, config | DDI `dev_info_t`, `pci_config_*`, `ddi_regs_map_setup` | `solaris/os/pci.c` |
| MMIO `ioread/iowrite` | `ddi_get*`/`ddi_put*` + endian access handles | `solaris/os/io.c` |
| DMA mapping/scatterlist | `ddi_dma_*`, DMA cookies | `solaris/os/dma.c` |
| IRQ/MSI/MSI-X | `ddi_intr_*` | `solaris/os/interrupt.c` |
| kmalloc/slab | `kmem_*` compatibility allocator | `solaris/os/memory.c` |
| mutex/spin/completion | Solaris mutex/CV/atomics | `solaris/os/sync.c` |
| workqueues | Solaris taskq | `solaris/os/workqueue.c` |
| request_firmware | Solaris firmware/module loader abstraction | `solaris/os/firmware.c` |
| copy_to/from_user | `ddi_copyin` / `ddi_copyout` | `solaris/os/uaccess.c` |
| Linux module/device registration | Solaris `dev_ops`, `cb_ops`, attach/detach | `solaris/nouveau/nouveau_solaris_module.c` |
| DRM file/ioctl | Solaris char device + Linux-compatible DRM ioctl numbers | `solaris/drm/` |
| render node | Solaris minor node `/dev/dri/renderD*` | `solaris/drm/drm_solaris_render_node.c` |
| mmap/devmap | Solaris `devmap`/`mmap` hooks | `solaris/drm/drm_solaris_mmap.c` |
| GEM/TTM/GPUVM | ported reduced modern DRM memory stack | upstream + `solaris/drm/` |
| syncobj/fences | Solaris-backed DRM synchronization | `solaris/drm/drm_solaris_syncobj.c` |
| PRIME/dma-buf | Solaris buffer-export abstraction | `solaris/drm/drm_solaris_prime.c` |
| per-app render offload | DRI_PRIME-compatible selector + present bridge | `solaris/offload/` |

## P0 features intentionally omitted

KMS/display engine, connectors, HDMI/DP, backlight, ACPI laptop paths, fbdev, SVM/HMM, runtime PM sophistication, debugfs/sysfs equivalents, and full suspend/resume.
