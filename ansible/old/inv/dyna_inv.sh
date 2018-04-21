#!/bin/bash
if  [[ $1 = "--list" ]]; then
  #cat inventory.json
	python dyna_inv.py
fi
