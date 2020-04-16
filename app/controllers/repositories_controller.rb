class RepositoriesController < ApplicationController
  def index
    @repos = if params[:q].present?
      client = Octokit::Client.new
      response = client.search_repositories(params[:q])
      response.items.map { |item| Repo.new(item.name) }
    else
      []
    end
  end
end
