from enum import Enum

IssueState = Enum('IssueState', 'Open Closed')

class Issue:

    def __init__(self, projectName: str, issueId: int ):
        self._state = IssueState.Open
        self._projectName = projectName
        self._issueId = issueId

    def close(self):
        self._state = IssueState.Closed

    def reopen(self):
        self._state = IssueState.Open
