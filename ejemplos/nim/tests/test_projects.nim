import tables
import ../project/projects

let projectId: string= "Foo"

addProject( projectId )
assert getProject(projectId).id == projectId


