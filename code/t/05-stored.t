use Test;

use Project::Data::JSON;
use Project::Data::Mock;
use Project::Stored;
use Project::Issue;

my $data-file = "resources".IO ~~ :d
        ?? "resources/data.json"
        !! "../resources/data.json";

my $dator = Project::Data::JSON.new($data-file);
my $stored = Project::Stored.new($dator);
say $stored.data();

my $project-name = $stored.project-name;
my $issue-id=33;
my $milestone = Project::Milestone.new(:$project-name,:milestone-id(33));
    for (Open,Closed) -> $state {
        my $issue = Project::Issue.new( :$project-name, :$issue-id );
        $issue.close() if $state == Closed;
        $milestone.new-issue( $issue );
        $issue-id++;
    }
is($stored.milestones.keys.elems,2, "2 milestones before adding");
$stored.new-milestone($milestone);
is($stored.milestones.keys.elems,3, "3 milestones after adding");

$dator = Project::Data::Mock.new;
$stored = Project::Stored.new($dator);
say $stored.data();
is($stored.milestones.keys.elems,1, "1 milestone from mock");

done-testing;
