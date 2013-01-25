class CensusController < ApplicationController
  def index
    @auth_key = ENV['AUTH_KEY']
  end
end
