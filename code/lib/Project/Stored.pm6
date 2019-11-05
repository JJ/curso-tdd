use Project::Dator;
use Project::Milestone;
use Project::Issue;
use Project;

unit class Project::Stored does Project;

has Project::Dator $!dator;

method new( Project::Dator $dator ){
    my %data = $dator.load;
    my %milestones;
    for %data<milestones>.list -> %m {
        my $m-id = %m.keys[0].Int;
        my $milestone = Project::Milestone.new(
                project-name => %data<name>,
                milestone-id => $m-id
                );
        for %m.values[0].list -> %i {
            $milestone.new-issue(
                    Project::Issue.new(
                            issue-id => %i.keys[0].Int,
                            project-name => %data<name>,
                            state => %i.values[0] eq "Open" ?? Open !! Closed
                            )
                    )
        }
        %milestones{$m-id} = $milestone;
    }
    return self.bless(
            dator => $dator,
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
