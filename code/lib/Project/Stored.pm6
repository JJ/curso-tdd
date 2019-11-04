use Project::Dator;

unit class Project::Stored is Project;

has $!dator;

submethod BUILD ( :$!project-name, :$!project-name) {}

method new-milestone( $milestone where $milestone.project-name eq
        $!project-name) {
    nextsame;
}
