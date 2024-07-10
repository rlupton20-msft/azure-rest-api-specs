# !/bin/bash
tsp compile . --emit @typespec/openapi3 --output-dir . && \
tsp compile . --emit @azure-tools/typespec-autorest --output-dir .