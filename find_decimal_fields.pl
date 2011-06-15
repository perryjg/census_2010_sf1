#!/usr/bin/perl -w
use strict;
use warnings;
use feature ':5.10.0';
use Data::Dump qw( dump ); $| = 1;

my $path = 'C:/data/census/census2010/SF1/alabama/';
opendir my( $dir ), $path;
my @files = grep /al\d{9}\.sf1/, readdir $dir;

for my $file ( @files ) {
    open my($fh), $path . $file or die $!;
    while (<$fh>) {
        if ( /\./ ) {
            say $file;
            say $_;
            last;
        }
        last if $. > 100;
    }
    close $fh;
}