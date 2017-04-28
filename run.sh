#!/bin/bash

# import database at first
mysql -u $1 -p$1 < Stockanalyses_prod.sql 
