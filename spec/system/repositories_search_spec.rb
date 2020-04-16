require "rails_helper"

RSpec.describe "Search repositories", type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:repo) { double(:repo, name: "noSecrets4NSA") }
  let(:result) { SearchRepositories::Success.new(items: [repo], total_count: 1) }

  context "basic search" do
    before do
      allow_any_instance_of(Octokit::Client).to receive(:search_repositories).and_return(response)
      allow_any_instance_of(SearchRepositories).to receive(:call)
        .and_return(result)
    end

    it "enables search across Github repositories" do
      visit "/?search"

      fill_in "q", with: "NSA secrets"
      click_button "Search"

      expect(page).to have_text("noSecrets4NSA")
    end
  end
end
