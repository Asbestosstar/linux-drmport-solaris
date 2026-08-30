/* SPDX-License-Identifier: GPL-2.0-only */
#ifndef _DRM_SOLARIS_H
#define _DRM_SOLARIS_H

/* Solaris backing object for the subset of Linux DRM required by Nouveau/NVK. */
struct drm_solaris_device;
struct drm_solaris_file;

int drm_solaris_register_render_node(struct drm_solaris_device *sdev);
void drm_solaris_unregister_render_node(struct drm_solaris_device *sdev);

#endif
