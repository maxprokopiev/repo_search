class Repo
  attr_reader :name, :login, :description

  def initialize(name, login, description)
    @name = name
    @login = login
    @description = description
  end
end
