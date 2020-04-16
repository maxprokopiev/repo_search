class SearchRepositories
  class Success < OpenStruct
    def deconstruct
      [items, total_count]
    end
  end

  class Error < OpenStruct
    def deconstruct
      [error]
    end
  end

  RESULTS_PER_PAGE = 12

  def self.call(*args)
    new(Octokit::Client.new).call(*args)
  end

  def initialize(client)
    @client = client
  end

  def call(query)
    response = get_repos(query)

    if response.items && response.items.present? then
      Success.new(
        items: get_items(response.items),
        total_count: response.total_count
      )
    else
      Error.new(error: :not_found)
    end
  rescue Octokit::TooManyRequests
    Error.new(error: :too_many_requests)
  end

  private

  def get_repos(query)
    @client.search_repositories(query, per_page: RESULTS_PER_PAGE)
  end

  def get_items(items)
    items.map { |item| Repo.new(item.name, item.owner.login, item.description) }
  end
end
