#[derive(Debug)]
enum IssueState {
    Open,
    Closed,
}

#[derive(Debug)]
struct Issue {
    state: IssueState,
    project_name: String,
    issue_id: u64,
}

fn main() {
    let this_issue = Issue {
        state: IssueState::Closed,
        project_name: String::from("NewProject"),
        issue_id: 1,
    };
    println!("{:?}", this_issue);
    let that_issue = Issue {
        state: IssueState::Open,
        project_name: String::from("NewProject"),
        issue_id: 3,
    };
    println!("{:?}", that_issue);
}
