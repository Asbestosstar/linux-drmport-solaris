# SPARC big-endian audit

Treat endian work as four separate classes:

1. MMIO registers: use Solaris DDI access handles and explicit LE/BE helpers.
2. DMA/shared memory: define byte order for every structure visible to the GPU/GSP.
3. Command streams: GPU packet formats are not host-native C structures; encode fields explicitly.
4. Firmware/GSP-RM messages: never cast arbitrary firmware bytes to host-native structures without conversion.

Nouveau/NVKM has existing big-endian-aware helpers and should be preserved. Nova currently excludes `CPU_BIG_ENDIAN`; do not remove that guard until every firmware, MMIO, DMA, and Rust layout assumption has been audited.
