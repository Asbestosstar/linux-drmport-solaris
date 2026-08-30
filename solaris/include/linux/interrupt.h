/* SPDX-License-Identifier: GPL-2.0-only */
#ifndef _SOLARIS_LINUXKPI_interrupt_H
#define _SOLARIS_LINUXKPI_interrupt_H

/*
 * Solaris compatibility header for <linux/interrupt.h>.
 * Keep the public shape close enough to Linux for Nouveau/DRM source reuse.
 * Implement OS behavior in solaris/os rather than sprinkling __sun conditionals
 * throughout NVKM.
 */

#include <solaris_gpu/compat.h>

#endif
