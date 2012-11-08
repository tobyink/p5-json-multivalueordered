use Test::More tests => 2;
use JSON::MultiValueOrdered;

my $str = <<'JSON';
{
	"a": [
		1,
		2,
		3
	],
	"b": {
		"c": 4,
		"d": [
			1
		],
		"e": [],
		"f": {}
	}
}
JSON

my $json = JSON::MultiValueOrdered->new(pretty => 1);

ok($json->pretty);

is(
	$json->encode($json->decode($str)),
	$str,
);
