use Project::Issue;
use Project::Milestone;

use X::Project::NoSuchIssue;

unit class Project::Issues;

has %!issues;

method add( Project::Issue $issue ) {
    %!issues{$issue.issue-id} = $issue;
}

method delete( UInt $issue-id ) {
    if ~$issue-id ∈ %!issues.keys {
        %!issues{$issue-id}:delete;
    } else {
        X::Project::NoSuchIssue.new( :$issue-id ).throw;
    }
}

method all() { %!issues };

method close( UInt $issue-id ) {
    if ~$issue-id ∈ %!issues.keys {
        %!issues{$issue-id}.close;
    } else {
        X::Project::NoSuchIssue.new( :$issue-id ).throw;
    }
}

method get( UInt $issue-id --> Project::Issue ) {
    if ~$issue-id ∈ %!issues.keys {
        return %!issues{$issue-id};
    } else {
        X::Project::NoSuchIssue.new( :$issue-id ).throw
    }
}

method move-to( Project::Milestone $milestone,
                UInt $issue-id ) {
    X::Project::NoSuchIssue.new( :$issue-id ).throw
        unless ~$issue-id ∈ %!issues.keys;
    $milestone.new-issue( %!issues{$issue-id} );
    %!issues{$issue-id}:delete;
}
