#[derive(Debug)]
pub struct Project {
    pub project_name: String,
}

pub fn project_factory( project_name: String ) -> Project {
    return Project { project_name: project_name }
}
