class CollaborationsController < ApplicationController
  def new
    @wiki = Wiki.find(params[:wiki_id])
  end

  def create
    email = params[:email] # The email submitted by the form
    user = User.find_by(email: email)

    wiki_id = params[:wiki_id] # The wiki id taken from the URL
    wiki = current_user.wikis.find(wiki_id)

    Collaboration.create!(wiki: wiki, user: user)

    redirect_to wiki, notice: "Collaborator #{user.email} added!"
  end
end
