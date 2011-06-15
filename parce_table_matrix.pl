#!/usr/bin/perl -w
use strict;
use warnings;
use feature ':5.12.0';
use Data::Dump qw( dump ); $| = 1;

open my $fw, 'c:/data/census/census2010/SF1/sf1_table_matrix_section.txt' or die;

my @fields;
while(<$fw>) {
    next unless $. > 12;
    if ( my( $tbl ) = /^File +(\d{2})/ ) {
        if ( $tbl > 1 ) {
            say '  ' . join ",\n  ", @fields;
            say ") ENGINE=MYISAM;\n";
            undef @fields;
        }
        say "DROP TABLE IF EXISTS sf1_p$tbl;";
        say "CREATE TABLE IF NOT EXISTS sf1_p$tbl (";
    }
    elsif ( my( $string ) = /((?:FILEID|STUSAB|CHARITER|CIFSN|LOGRECNO).*$)/ ) {
        my @field =  split / \t/, $string;
        push @fields, "$field[0]\tCHAR($field[1])"
    }
    elsif ( /([PH]\d{3}[A-Z0-9]\d+)/ ) {
        push @fields, "$1\tINT";
    }
    elsif ( /([PH]C[OT]\d{3}[A-Z0-9]\d+)/ ) {
        push @fields,  "$1\tINT";
    }
}
say '  ' . join ",\n  ", @fields;
say ") ENGINE=MYISAM;";

close $fw;
