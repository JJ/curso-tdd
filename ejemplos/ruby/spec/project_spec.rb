require "Project"

PROJECT_NAME = 'Foo'

describe Project do

  before do
    @project = Project.new(PROJECT_NAME )
  end

  describe "Sin issues" do
    it "has no issues when initialized" do
      expect( @project.name ).to be( PROJECT_NAME )
    end
  end
end
