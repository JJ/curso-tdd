require "project"

PROJECT_NAME = 'Foo'

class NoLogger
end

describe Project do

  before do
    @project = Project.new(PROJECT_NAME,NoLogger.new() )
  end

  describe "Nombre asignado" do
    it "has the correct name" do
      expect(@project.name).to be PROJECT_NAME
    end
  end

  describe "Sin issues" do
    it "has no issues when initialized" do
      expect( @project.issues.length ).to be 0
    end
  end

end
