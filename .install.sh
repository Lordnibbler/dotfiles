#!/bin/bash
for f in *; do
  BASE=`basename $f`;
  CWD=`pwd`

  # Don't link install script or dotfiles
  if [[ ("${BASE:0:1}" == ".")]]; then
    continue
  fi

  # Don't link install the readme :)
  if [[ "${BASE}" == "README.md" ]]; then
    continue
  fi

  ln -sin "${CWD}/${BASE}" "${HOME}/.${BASE}"
done
