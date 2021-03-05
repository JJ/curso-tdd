class Milestone:
    
    def __init__(self, projectName: str, milestoneId: int ):
        self._projectName = projectName
        self._milestoneId = milestoneId
        self._issues = []

    @property
    def projectName(self):
        return self._projectName

    @property
    def milestoneId(self):
        return self._milestoneId

class NoIssueException(Exception):
    def __init__(self,*args,**kwargs):
        Exception.__init__(self,"Milestone sin issues")