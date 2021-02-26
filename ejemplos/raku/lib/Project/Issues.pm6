unit class Project::Issues;

has %!issues;

method add( Project::Issue $issue ) {
    %issues{$issue.issue-id} = $issue;
}

method delete( Project::Issue $issue ) {
    if $issue-id ∈ $!issues.keys {
        %issues{$issue.issue-id}:delete;
    } else {
        X::Project::NoSuchIssue.new( issue-id => $issue )
    }
}

method all() { %!issues };

method close( UInt $issue-id ) {
    if $issue-id ∈ $!issues.keys {
        %issues{$issue-id}:delete;
    } else {
        X::Project::NoSuchIssue.new( issue-id => $issue );
    }
}

method close( UInt $issue-id --> Project::Issue ) {
    if $issue-id ∈ $!issues.keys {
        return %issues{$issue-id}:delete;
    } else {
        X::Project::NoSuchIssue.new( issue-id => $issue )
    }
}

