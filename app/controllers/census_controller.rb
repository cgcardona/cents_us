class CensusController < ApplicationController
  def index
    @auth_key = YAML.load_file("config/auth_key.yml")
  end
end
