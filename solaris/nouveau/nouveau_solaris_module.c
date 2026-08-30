/* SPDX-License-Identifier: GPL-2.0-only */
#include <solaris_gpu/compat.h>
#include <drm/drm_solaris.h>

/*
 * Solaris DDI entry point skeleton.
 *
 * P0 attach path:
 *   1. Match exact NVIDIA PCI IDs enabled in the package/driver aliases.
 *   2. Create LinuxKPI pci_dev wrapper from dev_info_t.
 *   3. Map BARs with endian-safe DDI handles.
 *   4. Initialize NVKM in render-only mode.
 *   5. Register /dev/dri/renderD* once DRM core is available.
 *
 * Do not claim display ownership in P0; AST remains the console/display driver.
 */

/* TODO: _init/_fini/_info, dev_ops, cb_ops, attach/detach/quiesce. */
