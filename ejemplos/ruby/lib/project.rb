module IssueStatus
  OPEN = 1
  CLOSED = 2
end

module Named
  attr_reader :name
end

class Project
  include Named
  attr_reader :issues, :milestones

  def initialize( name )
    @name = name
    @issues = []
    @milestones = []
  end

  class Issue
    include Named
    attr_reader :status

    def initialize( name )
      @name = name
    end
  end

end
