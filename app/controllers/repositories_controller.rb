class RepositoriesController < ApplicationController
  def index
    @repos = if params[:q].present?
      case SearchRepositories.call(params[:q])
      in [error]
        RepositoriesPresenter.new(error: error)
      in [items, total_count]
        RepositoriesPresenter.new(repos: items, total_count: total_count)
      end
    else
      RepositoriesPresenter.new
    end
  end
end
