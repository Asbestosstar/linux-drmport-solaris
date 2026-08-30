/* SPDX-License-Identifier: GPL-2.0-only */
#include <stdlib.h>
#include <string.h>
#include <solaris_gpu/offload.h>

/*
 * Provider policy skeleton.
 * Keep AST as display provider and select a DRM render node for applications
 * that opt into DRI_PRIME/SOLARIS_RENDER_OFFLOAD.
 */
int
solaris_gpu_select_render_provider(struct solaris_gpu_provider *out)
{
    const char *offload = getenv("SOLARIS_RENDER_OFFLOAD");
    if (!out || !offload || strcmp(offload, "0") == 0)
        return -1;

    /* TODO: enumerate /dev/dri/renderD*, query vendor/device through DRM. */
    memset(out, 0, sizeof (*out));
    out->vendor_id = 0x10de;
    out->flags = SOLARIS_GPU_PROVIDER_RENDER;
    return 0;
}
