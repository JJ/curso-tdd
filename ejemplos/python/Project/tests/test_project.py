import pytest

from Project.core import Project

PROJECT_NAME = "foo"

@pytest.fixture
def project():
    return Project( PROJECT_NAME )

def test_data(project):
    assert project.name == PROJECT_NAME
