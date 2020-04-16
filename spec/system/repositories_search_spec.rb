require "rails_helper"

RSpec.describe "Search repositories", type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:repo) { double(:repo, name: "noSecrets4NSA") }
  let(:response) { double(:response, items: [repo]) }

  before do
    allow_any_instance_of(Octokit::Client).to receive(:search_repositories).and_return(response)
  end

  it "enables search across Github repositories" do
    visit "/?search"

    fill_in "q", with: "NSA secrets"
    click_button "Search"

    expect(page).to have_text("noSecrets4NSA")
  end
end
