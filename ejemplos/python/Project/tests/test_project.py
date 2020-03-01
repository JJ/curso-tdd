import pytest

from Project.core import Project

@pytest.fixture
def project():
    project = Project()
    return project

def test_data(project):
    assert  len(project.data) > 0
