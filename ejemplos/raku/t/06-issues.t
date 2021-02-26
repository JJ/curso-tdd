use Test;

use Project::Issues;

constant $project-name = "Foo";
constant $issue-id = 1;

my $agg-issues = Project::Issues.new();
$agg-issues.add( Project::Issue.new( :$project-name, :$issue-id ) );

is( $agg-issues.all.keys.elems,1, "Added one issue" );

throws-like { my $not-an-issue = $agg-issues.get( 33 ) },
        X::Project::NoSuchIssue,
        "Excepciones correctas";


done-testing;
