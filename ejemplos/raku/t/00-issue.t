use Test; # -*- mode: perl6 -*-

use Project::Issue;

constant $project-name = "Foo";
constant $issue-id = 1;

my $issue = Project::Issue.new( :$project-name, :$issue-id );

is( $issue.project-name(), $project-name, "Correct project name");
is( $issue.issue-id(), $issue-id, "Correct issue ID");
is( $issue.state, Open, "Initially states should be open");
$issue.close;
is( $issue.state, Closed, "Issue has been closed");
$issue.reopen;
is( $issue.state, Open, "Initially states should be open");

done-testing;
