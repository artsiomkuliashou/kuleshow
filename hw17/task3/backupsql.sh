#!/bin/bash

name_db=$1
pg_dump $name_db > /var/lib/postgresql/'$name_db'_$(date +%Y-%m).sql

