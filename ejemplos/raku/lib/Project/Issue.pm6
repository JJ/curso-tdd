enum IssueState <Open Closed>;

unit class Project::Issue;

has IssueState $!state = Open;
has Str $!project-name;
has UInt $!issue-id;

multi submethod BUILD( UInt :$!issue-id!,
		       Str :$!project-name!) {}


method close() { $!state = Closed }
method reopen() { $!state = Open }
method project-name( --> Str ) { return $!project-name }
method issue-id( --> UInt ) { return $!issue-id }
method state( --> IssueState ) { return $!state }

