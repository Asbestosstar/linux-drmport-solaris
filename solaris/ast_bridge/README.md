# Optional AST DRM-lite bridge

Not required for P0.

The first render-offload implementation copies completed NVIDIA images into an Xorg drawable served by the existing Solaris AST framebuffer driver.

If later desired, this directory can host a small DRM/KMS compatibility wrapper around AST so it acts as a PRIME/DRI3 display provider. Do not replace the proven SPARC AST console driver during early NVIDIA bring-up.
