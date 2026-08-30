# Patch policy

Keep this directory small.

Preferred order:
1. Implement Linux APIs in `solaris/include/linux` and `solaris/os`.
2. Implement generic DRM OS hooks in `solaris/drm`.
3. Only patch Nouveau/NVKM where an OS-neutral abstraction is impossible or for an explicit render-only compile option.
4. Keep Nova changes separate from Nouveau changes.

Suggested future patch series:
- 0001-nouveau-add-solaris-render-only-build-mode.patch
- 0002-drm-add-solaris-os-hooks.patch
- 0003-nouveau-disable-linux-only-acpi-pm-svm-on-solaris.patch
- 0004-nouveau-sparc-endian-audit-fixes.patch
