#!/bin/bash

function error() {
  echo "ERROR: $1"
  exit 1
}

function patch_web3() {
  patch "$(npm root)/web3-eth-abi/dist/web3-eth-abi.cjs.js" < "$(pwd)/patch/web3-eth-abi.txt" || error "Failed to patch web3-eth-abi module"
}

if [ -d "$(npm root)/web3-eth-abi" ]; then
  echo "Patching web3-eth-abi.cjs.js..."
  patch_web3
else
  echo 'web3-eth-abi module not installed. Skipping...'
fi
