import pytest
from Project.Issue import Issue, IssueState

PROJECTNAME = "testProject"

@pytest.fixture
def issue():
    issue = Issue(PROJECTNAME)
    return issue

def test_has_name_when_created(issue):
    assert issue.projectName  == PROJECTNAME
    
def test_is_open_when_created(issue):
    assert  issue.state == IssueState.Open

def test_is_closed_when_you_close_it(issue):
    issue.close()
    assert  issue.state == IssueState.Closed

def test_is_open_when_you_reopen_it(issue):
    issue.reopen()
    assert  issue.state == IssueState.Open

