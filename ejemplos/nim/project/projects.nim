import tables, ../project

var projectList* = initTable[string, Project]()

proc addProject *( id: string ) =
  projectList[id] = Project( id: id )


