/* SPDX-License-Identifier: GPL-2.0-only */
#ifndef _SOLARIS_GPU_COMPAT_H
#define _SOLARIS_GPU_COMPAT_H

/* Central include for Solaris/LinuxKPI compatibility work. */

#ifdef __sun
#include <sys/types.h>
#include <sys/ddi.h>
#include <sys/sunddi.h>
#include <sys/pci.h>
#include <sys/kmem.h>
#include <sys/mutex.h>
#include <sys/condvar.h>
#include <sys/atomic.h>
#include <sys/taskq.h>
#endif

#endif
