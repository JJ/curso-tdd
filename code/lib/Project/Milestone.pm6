use Project::Issue;

unit class Project::Milestone;

has UInt $!milestone-id;
has %!issues = ();
has Str $!project-name;

submethod BUILD( :$!milestone-id, :$!project-name) {}

method new-issue( Project::Issue $issue where $issue.project-name eq $!project-name) {
    %!issues{$issue.issue-id} = $issue;
}

proto method issues( | ) { * }
multi method issues() { return %!issues }
multi method issues( IssueState $state ) {
    return %!issues.grep: *.value.state eq $state
}