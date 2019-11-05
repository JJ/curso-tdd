use Project::Dator;
use Project::Milestone;
use Project::Issue;
use Project;

unit class Project::Stored is Project;

has $!dator;

method new( $dator ) {
    my %data = $dator.load;
    my %milestones;
    for %data<milestones> -> $m {
        my $milestone = Project::Milestone.new(
                project-name => %data<name>,
                milestone-id => $m.key
                );
        for $m.values -> $i {
            $milestone.new-issue(
                    Project::Issue.new(
                            issue-id => $i.key,
                            project-name => %data<name>,
                            state => $i.value
                            )
                    )
        }
        %milestones{$m.key} = $milestone;
    }
    return self.bless(
            dator => $dator<,
            project-name => %data<name>,
            milestones => %milestones
            );
}

submethod BUILD ( :$!dator, :$!project-name, :%!milestones) {}

method new-milestone( $milestone where $milestone.project-name eq
        $!project-name) {
    callsame;
    $!dator.update( $!.data() );
}
