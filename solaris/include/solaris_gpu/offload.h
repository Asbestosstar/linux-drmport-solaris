/* SPDX-License-Identifier: GPL-2.0-only */
#ifndef _SOLARIS_GPU_OFFLOAD_H
#define _SOLARIS_GPU_OFFLOAD_H

#include <stdint.h>

struct solaris_gpu_provider {
    uint16_t vendor_id;
    uint16_t device_id;
    unsigned domain, bus, slot, function;
    int render_minor;
    unsigned flags;
};

#define SOLARIS_GPU_PROVIDER_RENDER  (1u << 0)
#define SOLARIS_GPU_PROVIDER_DISPLAY (1u << 1)

int solaris_gpu_select_render_provider(struct solaris_gpu_provider *out);
int solaris_gpu_present_copy(int render_fd, void *x11_cookie,
    uint32_t width, uint32_t height, uint32_t stride);

#endif
