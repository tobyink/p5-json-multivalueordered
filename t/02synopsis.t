use Test::More tests => 4;
use JSON::MultiValueOrdered;

my $j = JSON::MultiValueOrdered->new;
isa_ok $j, 'JSON::Tiny';

my $data = $j->decode(<<'JSON');
{
	"a": 1,
	"b": 2,
	"a": 3,
	"b": 4
}
JSON

# As you'd expect, for repeated values, the last value is used
is_deeply(
	$data,
	{ a => 3, b => 4 },
);

# But hashes within the structure are tied to Tie::Hash::MultiValueOrdered
is_deeply(
	[ tied(%$data)->get('b') ],
	[ 2, 4 ],
);

# And the extra information from the tied hash is used when re-encoding
is(
	$j->encode($data),
	q({"a":1,"b":2,"a":3,"b":4}),
);

done_testing;
