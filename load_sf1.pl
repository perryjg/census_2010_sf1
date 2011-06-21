#!/usr/bin/perl -w
use strict;
use warnings;
use feature ':5.10.0';
#use Data::Dump qw( dump ); $| = 1;

use DBI;

my $dbuser = '';
my $dbpassword = '';
my $dbtable = 'census_sf1_2010';
my $base_path = 'C:/data/census/census2010/SF1/';
my $state = 'alabama';
my $stab = 'al';

my $dbh = DBI->connect( "dbi:mysql:database=$dbtable", $dbuser, $dbpassword );

my $load_geo_template = <<'.';
LOAD DATA INFILE '%s%s/%2sgeo2010.sf1'
INTO TABLE sf1_geo
FIELDS TERMINATED BY ''
.
my $load_data_template = <<'.';
LOAD DATA INFILE '%s%s/%2s%05d2010.sf1'
INTO TABLE sf1_p%02d
FIELDS TERMINATED BY ','
.

say  sprintf 'TABLE: sf1_geo';
$dbh->do( sprintf 'TRUNCATE TABLE sf1_geo' );
say $dbh->do(  sprintf $load_geo_template, ( $base_path, $state
                                            , $stab ) );

for my $seg ( 1..47 ) {
    say  sprintf 'TABLE: sf1_p%02d', $seg;
    $dbh->do( sprintf 'TRUNCATE TABLE sf1_p%02d', $seg );
    say $dbh->do( sprintf $load_data_template, ( $base_path, $state, $stab, $seg, $seg ) );
}

$dbh->disconnect;



