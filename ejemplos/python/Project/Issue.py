from enum import Enum

IssueState = Enum('IssueState', 'Open Closed')

class Issue:

    def __init__(self, projectName: str, issueId: int ):
        self.state = IssueState.Open
        self.projectName = projectName
        self.issueId = issueId

    def close(self):
        self.state = IssueState.Closed

    def reopen(self):
        self.state = IssueState.Open
