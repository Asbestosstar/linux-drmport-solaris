#!/bin/sh
# Placeholder: keep the imported drivers/gpu snapshot separate from Solaris glue.
set -eu
echo "Sync policy: refresh upstream/gpu from a known Linux kernel commit, then reapply only patches/ and solaris/ glue."
echo "Do not hand-edit NVKM broadly unless the change is a genuine portability fix suitable for upstream."
