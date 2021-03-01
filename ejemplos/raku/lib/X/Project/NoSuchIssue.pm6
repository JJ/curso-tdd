unit class X::Project::NoSuchIssue is Exception;

has $!issue-id;

method message() {    "There is no issue with that id $!issue-id" }
