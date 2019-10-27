use Test;

use Project::Issue;
use Project::Milestone;

constant $project-name = "Foo";
my $issue-id = 1;

my $milestone = Project::Milestone.new(:$project-name,:milestone-id(1));
for (Open,Closed) -> $state {
    my $issue = Project::Issue.new( :$project-name, :$issue-id );
    $issue.close() if $state == Closed;
    $milestone.new-issue( $issue );
    is( $milestone.issues.keys.elems, $issue-id,
            "Correct number of issues added");
    $issue-id++;
}
is( $milestone.issues(Open).keys.elems, 1,
        "Correct number of open issues added");

throws-like {
    $milestone.new-issue(
            Project::Issue.new( :project-name("Bar"), :$issue-id )
            );
    }, X::TypeCheck::Binding::Parameter, "Can't add milestone of another project";
done-testing;
