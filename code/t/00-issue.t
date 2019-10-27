use Test;

use Project::Issue;

my $issue = Project::Issue.new( :project-name("Foo"), :issue-id(1));

is( $issue.state, Open, "Initially states should be open");
$issue.close;
is( $issue.state, Closed, "Issue has been closed");
$issue.reopen;
is( $issue.state, Open, "Initially states should be open");

done-testing;
