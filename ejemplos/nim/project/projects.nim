import ../project

type
  ProjectDesc= tuple
    id: string
    project: Project

var projects*: seq[ProjectDesc] = @[]

proc addProject *( id: string ) =
  var
    thisProject: Project

  thisProject = Project( id: id )
  projects.add( (id: id, project: thisProject ) )
