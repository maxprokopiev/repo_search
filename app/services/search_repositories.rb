class SearchRepositories
  def self.call(*args)
    new(Octokit::Client.new).call(*args)
  end

  def initialize(client)
    @client = client
  end

  def call(query)
    response = @client.search_repositories(query)
    response.items.map { |item| Repo.new(item.name) }
  end
end
