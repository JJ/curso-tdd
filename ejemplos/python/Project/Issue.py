from enum import Enum

IssueState = Enum('IssueState', 'Open Closed')

class Issue:

    def __init__(self, projectName):
        self.state = IssueState.Open
        self.projectName = projectName

    def close(self):
        self.state = IssueState.Closed

    def reopen(self):
        self.state = IssueState.Open
