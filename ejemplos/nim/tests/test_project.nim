import ../project

const projectId= "Foo"
var
  thisProject: Project

thisProject = Project( id: projectId )

assert thisProject.id == projectId
