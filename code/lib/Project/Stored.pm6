use Project::Dator;
use Project::Milestone;
use Project::Issue;

unit class Project::Stored is Project;

has $!dator;

method new( $dator ) {
    my %data = $dator.load;
    my %milestones
    for %data<milestones> -> @m {
        my $milestone = Project::Milestone.new;
        for @m -> $i {

        }
    }
    return self.bless( :$file-name, data => from-json slurp $file-name );
}

submethod BUILD ( :$!project-name, :$!project-name) {}

method new-milestone( $milestone where $milestone.project-name eq
        $!project-name) {
    $!dator.update( $!.data() );
    nextsame;
}
