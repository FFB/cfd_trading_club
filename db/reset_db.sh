#! /usr/bin/env bash

#dropdb cfd_trading_club;
#create_db cfd_trading_club;

psql cfd_trading_club -f db/schema.sql

rm -r lib/cfd_trading_club/Schema/Result

script/cfd_trading_club_create.pl model DB DBIC::Schema cfd_trading_club::Schema create=static 'dbi:Pg:dbname=cfd_trading_club'
