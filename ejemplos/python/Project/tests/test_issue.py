import pytest
from Project.Issue import Issue, IssueState

@pytest.fixture
def issue():
    issue = Issue()
    return issue

def test_is_open_when_created(issue):
    assert  issue.state == IssueState.Open

def test_is_closed_when_you_close_it(issue):
    issue.close()
    assert  issue.state == IssueState.Closed

def test_is_open_when_you_reopen_it(issue):
    issue.reopen()
    assert  issue.state == IssueState.Open

