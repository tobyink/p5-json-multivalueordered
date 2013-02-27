use strict;
use warnings;
use Test::More;

{
	package Foo;
	use JSON::Tiny::Subclassable 'j';
	
	my $r = j('{"a":1,"a":2}');
	::ok($r->{a}==1 or $r->{a}==2);
}

{
	package Bar;
	use JSON::MultiValueOrdered 'j';
	
	my $r = j('{"a":1,"a":2}');
	::ok(tied(%$r), 'j() returns tied hashref');
	(tied %$r)->fetch_list;
	::is_deeply($r, { a => [1, 2] });
}

{
	package Foo;
	use JSON::MultiValueOrdered 'j' => { -as => 'json' };
	
	my $r = json('{"a":1,"a":2}');
	::ok(tied(%$r), 'json() returns tied hashref');
	(tied %$r)->fetch_list;
	::is_deeply($r, { a => [1, 2] });
}


done_testing;
