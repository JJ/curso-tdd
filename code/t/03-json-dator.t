use Test;

use Project::Data::JSON;

my $data-file = "resources".IO ~~ :d
        ?? "resources/data.json"
        !! "../resources/data.json";

my $dator = Project::Data::JSON.new($data-file);
ok( $dator.load, "Loads data");

done-testing;
