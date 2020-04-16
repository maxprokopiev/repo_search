require "rails_helper"

RSpec.describe "Search repositories", type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:repo) { double(:repo, name: "noSecrets4NSA") }
  let(:result) { SearchRepositories::Success.new(items: [repo], total_count: 1, page: 1) }

  context "basic search" do
    before do
      allow_any_instance_of(SearchRepositories).to receive(:call)
        .and_return(result)
    end

    it "enables search across Github repositories" do
      visit "/"

      fill_in "q", with: "NSA secrets"
      click_button "Search"

      expect(page).to have_text("noSecrets4NSA")
    end
  end

  context "no results" do
    let(:result) { SearchRepositories::Error.new(error: :not_found) }

    before do
      allow_any_instance_of(SearchRepositories).to receive(:call)
        .and_return(result)
    end

    it "shows an error message" do
      visit "/"

      fill_in "q", with: "There is still hope"
      click_button "Search"

      expect(page).to have_text("Nothing found")
    end
  end

end
