use Test;

use Project::Data::JSON;

my $data-file = "resources".IO ~~ :d
        ?? "resources/data.json"
        !! "../resources/data.json";

my $dator = Project::Data::JSON.new($data-file);
my %data = $dator.load;
ok( %data, "Loads data");
is( %data.keys.elems, 2, "Correct number of keys");


done-testing;
