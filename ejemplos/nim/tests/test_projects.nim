import tables
from ../project/projects import projectList, addProject

let projectId: string= "Foo"

addProject( projectId )
assert projectList[projectId].id == projectId


