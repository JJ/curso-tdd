use Project::Issue; # Needed for Open/Closed
use Stats;

unit role Project;

has %!milestones = {};
has Str $!project-name;

submethod BUILD( :$!project-name) {}

method new-milestone( $milestone where $milestone.project-name eq
        $!project-name) {
    %!milestones{$milestone.milestone-id} = $milestone;
}

method milestones() { return %!milestones }

method percentage-completed() {
    my %percentage-completed;
    for %!milestones.kv -> $key,$m {
        with $m.issues() {
            %percentage-completed{$key} =
                    $m.issues(Closed)*1.0 / $m.issues().elems;
        } else {
            %percentage-completed{$key}  = 0;
        }
    }
    return %percentage-completed;
}

method completion-summary() {
    my %percentage-completed = self.percentage-completed();
    return summary( %percentage-completed.values.list );
}

method data() {
    return {
        name => $!project-name,
        milestones => %!milestones.values.map(
                {
                    $_.milestone-id.Str =>
                            $_.issues.values.map( { $_.issue-id.Str => $_.state
                            } )
                }
                )
    };
}

method project-name() { $!project-name}