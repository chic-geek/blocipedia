class WelcomeController < ApplicationController
  def index
    @wikis = Wiki.public_wikis
  end
end
