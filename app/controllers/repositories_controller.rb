class RepositoriesController < ApplicationController
  def index
    @repos = if params[:q].present?
      SearchRepositories.call(params[:q])
    else
      []
    end
  end
end
