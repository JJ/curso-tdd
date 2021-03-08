enum issueStatus: [:open, :closed]

module Project
  attr_reader :issues, :name;

  def initialize( name )
    @name = name
    @issues = []
  end

end
