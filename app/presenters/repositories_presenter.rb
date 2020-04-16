class RepositoriesPresenter
  attr_reader :total_count, :current_page

  def initialize(repos: [], total_count: 0, current_page: 1, per_page: 1, error: nil)
    @repos = repos
    @total_count = total_count
    @current_page = current_page
    @per_page = per_page

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

  def page_count
    return @page_count if @page_count

    @page_count, last_page = @total_count.divmod(@per_page)
    @page_count += 1 if last_page > 0
  end
end
