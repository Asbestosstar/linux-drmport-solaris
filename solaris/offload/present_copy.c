/* SPDX-License-Identifier: GPL-2.0-only */
#include <solaris_gpu/offload.h>

/*
 * P0 presentation bridge for AST legacy framebuffer/Xorg:
 * NVK image -> NVIDIA copy engine -> pinned host staging -> X11 drawable.
 *
 * This deliberately does not require AST to implement Linux dma-buf/PRIME.
 * Synchronization must use the render driver's fence/syncobj before exposing
 * staging memory to the Xorg side.
 */
int
solaris_gpu_present_copy(int render_fd, void *x11_cookie,
    uint32_t width, uint32_t height, uint32_t stride)
{
    (void)render_fd;
    (void)x11_cookie;
    (void)width;
    (void)height;
    (void)stride;
    return -1; /* TODO */
}
