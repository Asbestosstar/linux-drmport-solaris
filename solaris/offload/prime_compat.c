/* SPDX-License-Identifier: GPL-2.0-only */
/*
 * Future PRIME-like buffer export/import abstraction.
 * Preserve DRM PRIME user-visible semantics where practical, but map the
 * backing storage to Solaris DMA handles/cookies rather than Linux dma-buf.
 */
