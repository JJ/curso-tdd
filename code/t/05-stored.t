use Test;

use Project::Data::JSON;
use Project::Stored;

my $data-file = "resources".IO ~~ :d
        ?? "resources/data.json"
        !! "../resources/data.json";

my $dator = Project::Data::JSON.new($data-file);
my $stored = Project::Stored.new($dator);
say $stored.data();
done-testing;
