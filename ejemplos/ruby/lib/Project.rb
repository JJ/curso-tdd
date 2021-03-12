enum issueStatus: [:open, :closed]

module Named
  attr_reader :name
end

class Project
  include Named
  attr_reader :issues, :milestones

  class Issue
    include Named
    attr_reader :status
  end

  def initialize( name )
    @name = name
    @issues = []
    @milestones = []
  end


end
