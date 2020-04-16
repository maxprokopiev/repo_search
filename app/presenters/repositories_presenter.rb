class RepositoriesPresenter
  attr_reader :total_count

  def initialize(repos: [], total_count: 0, error: nil)
    @repos = repos
    @total_count = total_count

    @error = error
  end

  def each
    @repos.each { |repo| yield repo }
  end

  def empty?
    !error? && @repos.empty?
  end

  def error?
    @error.present?
  end

  def error_message
    case @error
    when :not_found
      "Nothing found"
    when :too_many_requests
      "Try again in 10 minutes"
    else
      "Something went wrong"
    end
  end
end
