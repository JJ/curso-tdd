class Project:

    def __init__(self, name ):
        self.name = name

    def name(self):
        return self.name

    def newMilestone(self, milestone):
        pass;

    def milestones(self):
        pass

    def percentageCompleted(self):
        pass

    def completionSummary(self):
        pass

    def data(self):
        pass

class NoIssueException(Exception):
    def __init__(self,*args,**kwargs):
        Exception.__init__(self,"Milestone sin issues")
