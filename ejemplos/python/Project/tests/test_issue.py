import pytest
from Project.Issue import Issue, IssueState

@pytest.fixture
def issue():
    issue = Issue()
    return issue

def test_is_open_when_created(issue):
    assert  issue.state == IssueState.Open
