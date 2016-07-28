#!/bin/sh
chmod +x coinmarketcap.d
dmd -run coinmarketcap.d

mv *.csv ../data_coinmarketcap/