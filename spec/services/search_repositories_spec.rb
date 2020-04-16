require "rails_helper"

RSpec.describe SearchRepositories do
  context "when there are search results" do
    let(:repo) { double(:repo, name: "True Crypt") }
    let(:client) { double(:client, search_repositories: double(:result, items: [repo])) }
    let(:repos) { SearchRepositories.new(client).call("bnd secrets") }

    it "returns search results" do
      expect(repos).to have(1).item
      expect(repos.first.name).to eq "True Crypt"
    end
  end
end
