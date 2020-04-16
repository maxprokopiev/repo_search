class RepositoriesController < ApplicationController
  def index
    @repos = if params[:q].present?
      case SearchRepositories.call(params[:q], params[:page])
      in [error]
        RepositoriesPresenter.new(error: error)
      in [items, total_count, page]
        RepositoriesPresenter.new(
          repos: items,
          total_count: total_count,
          current_page: page,
          per_page: SearchRepositories::RESULTS_PER_PAGE
        )
      end
    else
      RepositoriesPresenter.new
    end
  end
end
