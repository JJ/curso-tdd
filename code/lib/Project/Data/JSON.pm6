use JSON::Fast;

unit class JSON does Dator;

has $!file-name;
has $!data;

submethod BUILD( $file-name where $file-name.IO ~~ :e) {
    return self.bless( :$file-name, data => from-json slurp $file-name );
}

submethod DESTROY() {
    spurt $!file-name, $!data;
}
method load() { $!data }
method update( $data ) { $!data = $data }