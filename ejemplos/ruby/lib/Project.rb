module Project
  attr_reader :issues, :name;

  def initialize( name )
    @name = name
    @issues = []
  end

end
