use Project::Issue;
use X::Project::NoIssue;

unit class Project::Milestone;

has UInt $!milestone-id;
has %!issues;
has Str $!project-name;

submethod BUILD( :$!milestone-id, :$!project-name) {}

method new-issue( Project::Issue $issue where $issue.project-name eq $!project-name) {
    %!issues{$issue.issue-id} = $issue;
}

proto method issues( | ) { * }
multi method issues() {
    if %!issues {return %!issues}
    else { X::Project::NoIssue.new.throw }
}

multi method issues( IssueState $state ) {
    if %!issues {
        return %!issues.grep: *.value.state eq $state
    }
    else {
        X::Project::NoIssue.new.throw
    }
}

method project-name() { $!project-name }
method milestone-id() { $!milestone-id }