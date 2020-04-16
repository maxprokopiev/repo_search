class Repo
  attr_reader :name, :login, :description, :url

  def initialize(name, login, description, url)
    @name = name
    @login = login
    @description = description
    @url = url
  end
end
