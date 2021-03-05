import pytest
from Project.Milestone import Milestone

PROJECTNAME = "testProject"
ISSUEID = 1

@pytest.fixture
def milestone():
    return Milestone(PROJECTNAME,ISSUEID)

def test_has_name_when_created(milestone):
    assert milestone.projectName  == PROJECTNAME


