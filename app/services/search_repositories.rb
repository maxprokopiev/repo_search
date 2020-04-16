class SearchRepositories
  class Success < OpenStruct
    def deconstruct
      [items, total_count, page]
    end
  end

  class Error < OpenStruct
    def deconstruct
      [error]
    end
  end

  RESULTS_PER_PAGE = 12
  MAX_RESULTS = 1000

  def self.call(*args)
    new(Octokit::Client.new).call(*args)
  end

  def initialize(client)
    @client = client
  end

  def call(query, page)
    page = (page || 1).to_i
    response = get_repos(query, page)

    if response.items && response.items.present? then
      Success.new(
        items: get_items(response.items),
        total_count: get_total_count(response.total_count),
        page: page
      )
    else
      Error.new(error: :not_found)
    end
  rescue Octokit::TooManyRequests
    Error.new(error: :too_many_requests)
  end

  private

  def get_repos(query, page)
    @client.search_repositories(query, page: page, per_page: RESULTS_PER_PAGE)
  end

  def get_items(items)
    items.map { |item| Repo.new(item.name, item.owner.login, item.description, item.html_url) }
  end

  def get_total_count(raw_total_count)
    [raw_total_count, MAX_RESULTS].min
  end
end
