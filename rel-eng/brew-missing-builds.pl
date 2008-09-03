#!/usr/bin/perl

use strict;
use warnings FATAL => 'all';
use File::Basename ();

my $tag = shift;
if (not defined $tag) {
	die "usage: $0 brew-tag-to-check\n";
}

my @brew_data = sort map { /^(\S+)/ and $1 } `brew list-tagged --quiet --latest $tag`;

my ($self_dir) = ($0 =~ m!(.*/)!);
if (not $self_dir) {
	$self_dir = './';
}

my @tagged_data;
for my $file (sort < ${self_dir}packages/* >) {
	local *FILE;
	open FILE, $file or die "Error reading [$file]: $!\n";
	my $line = <FILE>;
	close FILE;
	my $version;
	($version) = ($line =~ /^(\S+)/)
		and push @tagged_data, File::Basename::basename($file) . "-" . $version;
}

print "Data loaded\n";
exit diff_it(\@brew_data, \@tagged_data);

sub diff_it {
	my ($brew_data, $tagged_data) = @_;
	my ($bi, $ti) = (0, 0);
	my (@extra, @missing);
	while ($bi < @$brew_data) {
		if (not defined $tagged_data->[$ti]) {
			push @extra, $brew_data->[$bi++];
			next;
		}
		my $b = $brew_data->[$bi];
		$b =~ s/\.el\d\.sw$//;
		my $t = $tagged_data->[$ti];
		$t =~ s/^(buildsys-macros-.+)\.sw$/$1/;
		if ($b lt $t) {
			push @extra, $brew_data->[$bi++];
		} elsif ($b gt $t) {
			push @missing, $tagged_data->[$ti++];
		} else {
			$bi++;
			$ti++;
		}
	}
	if ($ti < @$tagged_data) {
		push @missing, @{$tagged_data}[$ti .. $#$tagged_data];
	}
	if (@extra) {
		print "Extra builds in brew:\n";
		print map "\t$_\n", @extra;
	}
	if (@missing) {
		print "Builds missing in brew:\n";
		print map "\t$_\n", @missing;
	}
	if (@extra or @missing) {
		return 1;
	}
	return 0;
}

