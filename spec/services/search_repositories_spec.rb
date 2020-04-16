require "rails_helper"

RSpec.describe SearchRepositories do
  context "when there are search results" do
    let(:repo) { double(:repo, name: "True Crypt", owner: double(:o, login: "revealer"), description: "") }
    let(:client) { double(:client, search_repositories: double(:result, total_count: 1, items: [repo])) }
    let(:repos) { SearchRepositories.new(client).call("bnd secrets", 1) }

    it "returns search results" do
      expect(repos).to be_a(SearchRepositories::Success)

      expect(repos.total_count).to eq 1
      expect(repos.items).to have(1).item
      expect(repos.items.first.name).to eq "True Crypt"
    end
  end

  context "when there are no search results" do
    let(:client) { double(:client, search_repositories: double(:result, total_count: 0, items: [])) }
    let(:result) { SearchRepositories.new(client).call("Thingsareonlygoingtogetbetter", 1) }

    it "returns an error" do
      expect(result).to be_a(SearchRepositories::Error)
      expect(result.error).to eq(:not_found)
    end
  end

  context "when API limit exceeded" do
    before do
      allow_any_instance_of(Octokit::Client).to receive(:search_repositories)
        .and_raise(Octokit::TooManyRequests)
    end

    let(:result) { SearchRepositories.call("Thingsareonlygoingtogetbetter", 1) }

    it "returns an error" do
      expect(result).to be_a(SearchRepositories::Error)
      expect(result.error).to eq(:too_many_requests)
    end
  end
end
