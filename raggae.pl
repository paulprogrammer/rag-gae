#!/usr/bin/perl

use Badger::URL;
use YAML::XS qw'LoadFile';

sub main() {
	foreach my $ramlFile ( @ARGV ) {
		my( $raml, $uriPath, $version, $uriObj);
		print "processing $ramlFile\n";
		$raml = LoadFile( $ramlFile);

		$uriPath = ${$raml}{'baseUri'};
		$version = ${$raml}{'version'};

		$uriPath =~ s/\{version\}/$version/g;
		$uriObj = Badger::URL->new($uriPath);

		print $uriObj->path, "\n";

		foreach my $path (keys(%{$raml})) {
			next if ! ($path =~ /^\//); #skip non-path elements
			doPathProcess( undef, $path);
		}
	}
}

sub doPathProcess( $$ ) {
	my ($context, $path)=@_;
	print $path, "\n";
}

main();
