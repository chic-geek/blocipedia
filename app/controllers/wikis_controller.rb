class WikisController < ApplicationController
  before_action :authenticate_user!

  ## create
  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new(params.require(:wiki).permit(:title, :body))
    @wiki.user_id = current_user.id
    if @wiki.save
      redirect_to @wiki, notice: "Your wiki has been created"
    else
      render "new"
    end
  end

  ## read
  def index
    @wikis = current_user.wikis
  end

  def show
    @wiki = current_user.wikis.find(params[:id])
  end

  ## update
  def edit
  end

  def update
  end

  ## delete
  def destroy
  end
end