#!/bin/bash

grep -o -E '[[:alpha:]]+(-[[:alpha:]]+)*' "${1:-/dev/stdin}" | wc -l