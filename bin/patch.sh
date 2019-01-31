#!/bin/bash

PKG_ROOT=$(cd "$(dirname "$0")/../"; pwd)

function error() {
  echo "ERROR: $1"
  exit 1
}

function info() {
  echo "INFO: $1"
}

function warn() {
  echo "WARN: $1"
}

function ensure_module_finder() {
  if [ -d "$(npm root)/snyk-resolve" ]; then
    info "Module Finder installed. Skipping..."
  else
    info "Installing Module Finder"
    npm install snyk-resolve
  fi
}

function patch_web3() {
  mpath=$(node "${PKG_ROOT}/bin/mfinder.js" web3-eth-abi)

  if [ ! -z "${mpath}" ] && [ -d "${mpath}" ]; then
    patch "${mpath}/dist/web3-eth-abi.cjs.js" < "${PKG_ROOT}/patch/web3-eth-abi.txt" || error "Failed to patch web3-eth-abi module"
  else
    warn 'Unable to locate web3-eth-abi module! Skipping...'
  fi
}

############# SCRIPT CONTENT #############

ensure_module_finder
patch_web3
