#!/usr/bin/perl -w
#
#  CREATE TABLE multigen (
#    SERIALNO   CHAR(7),
#    PUMA5      CHAR(5),
#    PUMA1      CHAR(5),
#    MSACMSA5   CHAR(4),
#    HWEIGHT    INT,
#    PERSONS    INT,
#    NPF        INT,
#    MGF        INT,
#    PRIMARY KEY ( SERIALNO )
#  ) ENGINE=MYISAM CHARSET=latin1

use strict;
use warnings;
use feature ':5.10.0';
use Data::Dump qw( dump ); $| = 1;

use DBI;

my $dbuser = '';
my $dbpswd = '';
my $dbname = 'census_pums_2000';
my $dbh = DBI->connect( "dbi:mysql:database=$dbname", $dbuser, $dbpswd );

my @fields = qw( SERIALNO PUMA5 PUMA1 MSACMSA5 HWEIGHT PERSONS NPF MGF );
my $hholder_race_sql = <<'.';
SELECT RACE1
FROM persons
WHERE SERIALNO = %s
  AND RELATE = '01'
.
my $relate_sql = <<'.';
SELECT RELATE
FROM persons
WHERE SERIALNO = %s
.
my $hh_select_sql = <<'.';
SELECT SERIALNO, PUMA5, PUMA1, MSACMSA5, 
       HWEIGHT, PERSONS, NPF
FROM households
WHERE HHT in( '1','2','3')
.
my $hholds = $dbh->prepare( $hh_select_sql );
$hholds->execute;
my $insert_sql = <<'.';
INSERT INTO multigen
VALUES(?,?,?,?,?,?,?,?)
.
my $insert = $dbh->prepare( $insert_sql );

my $rec_count = 0;
while( my $hh = $hholds->fetchrow_hashref ) {
    $hh->{RACE} = $dbh->selectrow_array( sprintf $hholder_race_sql, $hh->{SERIALNO} );
    
    my $relates = $dbh->selectcol_arrayref( sprintf $relate_sql, $hh->{SERIALNO} );
    #say join ',', @$relates;
    my $grandchild  = grep( /(?:08)/,          @$relates ) ? 1 : 0;
    my $child       = grep( /(?:03|04|05|10)/, @$relates ) ? 1 : 0;
    my $parent      = grep( /(?:07|09)/,       @$relates ) ? 1 : 0;
    my $grandparent = grep( /(?:14)/,          @$relates ) ? 1 : 0;
    
    my $family = 1 + $grandchild + $child + $parent + $grandparent;
    #say "$grandchild,$child,$parent,$grandparent: $family";

    $hh->{MGF} = $family >= 3 ? 1 : 0;
    #dump $hh;
    $rec_count += $insert->execute( @{$hh}{@fields} );
}
say "$rec_count records inserted";
$dbh->disconnect;