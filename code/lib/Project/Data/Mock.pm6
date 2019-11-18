use Project::Dator;

unit class Project::Data::Mock does Project::Dator;

has $!data = { "milestones" => [
    {
        "2" => [
            {
                "4" => "Closed"
            },
            {
                "3" => "Open"
            }
        ]
    }
    ],
    "name" => "Foo"
};

method load() { $!data }
method update( \data ) { $!data = data }
