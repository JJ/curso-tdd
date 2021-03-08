enum issueStatus: [:open, :closed]

class Project
  attr_reader :issues, :name: :milestones

  def initialize( name )
    @name = name
    @issues = []
    @milestones = []
  end


end
