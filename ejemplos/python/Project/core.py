"""
Project tendrá todo lo relacionado con los proyectos de estudiantes en una asignatura.
"""


class Project:
    """
    Clase contenedor de todo lo relacionado con un proyecto en GitHub
    """
    def __init__(self, name: str ):
        self._name = name

    @property
    def name(self):
        """
        Simplemente el nombre del proyecto
        """
        return self._name

    def new_milestone(self, milestone):
        pass

    def milestones(self):
        pass

    def percentage_completed(self):
        pass

    def completion_summary(self):
        pass

    def data(self):
        pass
