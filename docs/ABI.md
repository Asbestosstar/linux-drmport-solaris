# ABI policy

Preserve upstream Linux DRM/Nouveau UAPI structure layouts, ioctl numbers, fixed-width integer fields, and semantics whenever possible.

The objective is for upstream `libdrm_nouveau` and Mesa NVK to require little or no knowledge of Solaris beyond device discovery/presentation glue.

Do not invent Solaris-only replacements for `DRM_NOUVEAU_VM_INIT`, `DRM_NOUVEAU_VM_BIND`, or `DRM_NOUVEAU_EXEC` unless an unavoidable ABI conflict is demonstrated.

For 32-bit SPARC callers into a 64-bit SPARCV9 kernel, audit every ioctl for ILP32/LP64 layout differences. Prefer fixed-width UAPI types and explicit pointer-as-u64 conventions.
