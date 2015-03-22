class WelcomeController < ApplicationController
  def index
    @wikis = Wiki.visible_to(current_user)
  end
end
