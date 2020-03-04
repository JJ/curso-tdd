import pytest
from Project.Issue import Issue

@pytest.fixture
def issue():
    issue = Issue()
    return issue

def test_data(issue):
    assert  len(issue.data) > 0
