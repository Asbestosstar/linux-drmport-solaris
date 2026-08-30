# Port status

Current state: architectural skeleton only.

## Chosen P0
- Nouveau/NVKM
- render-only NVIDIA GPU
- Solaris AST remains display/console
- Linux-compatible DRM/Nouveau UAPI
- per-process `DRI_PRIME`-style selection
- copy-present bridge first, zero-copy later

## Deferred
- Nova production path
- NVIDIA KMS/display
- AST DRM conversion
- SVM/HMM
- full PRIME/dma-buf equivalent
