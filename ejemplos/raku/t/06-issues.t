use Test;

use Project::Issues;
use Project::Milestone;

constant $project-name = "Foo";
constant $issue-id = 1;

my $agg-issues = Project::Issues.new();
$agg-issues.add( Project::Issue.new( :$project-name, :$issue-id ) );

is( $agg-issues.all.keys.elems,1, "Added one issue" );

throws-like { my $not-an-issue = $agg-issues.get( 33 ) },
        X::Project::NoSuchIssue,
        "Excepciones correctas";

my $milestone = Project::Milestone.new(:$project-name,:milestone-id(1));

$agg-issues.move-to( $milestone, $issue-id);
is( $agg-issues.all.keys.elems, 0 , "No more issues" );

done-testing;
