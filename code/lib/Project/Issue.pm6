enum IssueState <Open Closed>;

unit class Project::Issue;

has IssueState $!state = Open;
has Str $!project-name;
has UInt $!issue-id;

method close() { $!state = Closed }
method reopen() { $!state = Open }
method state( --> IssueState ) { return $!state }




