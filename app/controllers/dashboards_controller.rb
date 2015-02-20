class DashboardsController < ApplicationController
  def index
    # members = Rails.cache.fetch("organization", expires_in: 1.day) do
    #   #returns array or usernames
    #   Octokit.organization_members('thredup').map(&:login)
    # end

    @repo_pr = {}
    repos.map do |repo|
      @repo_pr.merge!({"#{repo}" => create_user_pr_count(repo)})
    end
  end


  def repos
    Rails.cache.fetch("organization") do
      ['thredUP3', 'tup-ops', 'tup-listing-service', 'tup-putaway']
    end
  end

  def create_user_pr_count(repo)
    #if I didn't put the per page to 100 it limited me to 30prs
    client = Octokit::Client.new(:access_token => current_user.token)
    mentions = client.search_issues("state:open repo:thredup/#{repo} is:pr", per_page: 100)[:items].flat_map{ |pr| pr.body.scan(/@[a-zA-z\d]*/)  }
    mentions.inject(Hash.new(0)) { |h, e| h[e] += 1 ; h }
    #returns something like
    # {"@edmundonm"=>11,
    # "@BraydenCleary"=>1,
    # "@lennonc"=>2,
    # "@dandemeyere"=>9,
    # "@florrain"=>4,
    # "@syedmusamah"=>1,
    # "@moserrya"=>2,
    # "@clwang"=>6,
    # "@thomasdevoy"=>7,
    # "@12and1studio"=>8,
    # "@HeidiHowland"=>4,
    # "@KMJo"=>12,
    # "@thredup"=>7,
    # "@shinsal"=>5,
    # "@advaitmahashabde"=>3,
    # "@matthewhaguemh"=>7,
    # "@kerrieyee"=>2,
    # "@chrishomer"=>7,
    # "@"=>1,
    # "@MehdiTUP"=>1,
    # "@msanthanam"=>1,
    # "@jmbeck"=>1}
  end
end
