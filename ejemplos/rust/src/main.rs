use simple_logger::SimpleLogger;

mod project;

#[derive(Debug)]
pub enum IssueState {
    Open,
    Closed,
}

#[derive(Debug)]
pub struct Issue {
    state: IssueState,
    project_name: String,
    issue_id: u64,
}

pub fn issue_factory( project_name: String,
                      issue_id: u64) -> Issue {
    log::debug!( "Creating closed issue for project {} with id {}", project_name, issue_id );
    return Issue { state: IssueState::Closed,
                   project_name: project_name,
                   issue_id: issue_id }
}

fn main() {
    SimpleLogger::new().init().unwrap();
    let project_name: &str = "CoolProject";
    let this_project = project::project_factory(project_name.to_string());
    log::debug!( "{}{}","Created project ", this_project.project_name.to_string() );
    let this_issue = issue_factory(project_name.to_string(), 1 );
    let mut that_issue = issue_factory( project_name.to_string(), this_issue.issue_id + 1 );
    that_issue.state = IssueState::Open; // Avoid warning
    log::debug!("Changed state to Open");
}

#[cfg(test)]
mod tests {
    use super::*;
    #[test]
    fn check_creation() {
        assert_eq!(issue_factory(String::from("CoolProject"), 1 ).issue_id, 1);
        assert_eq!(issue_factory(String::from("CoolProject"), 1 ).project_name, "CoolProject");
    }
}
