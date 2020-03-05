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

    @property
    def state(self):
        return self._state

    @property
    def projectName(self):
        return self._projectName

    @property
    def issueId(self):
        return self._issueId
