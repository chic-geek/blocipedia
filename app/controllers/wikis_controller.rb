class WikisController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  ## create
  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    @wiki = Wiki.new(params.require(:wiki).permit(:title, :body, :private))
    @wiki.user_id = current_user.id
    authorize @wiki
    if @wiki.save
      redirect_to @wiki, notice: "Your wiki has been created"
    else
      render "new"
    end
  end

  ## read
  def index
    @wikis = Wiki.visible_to(current_user)
    # @wikis = current_user.wikis
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  ## update
  def edit
    @wiki = Wiki.visible_to(current_user).find(params[:id])
  end

  def update
    @wiki = Wiki.visible_to(current_user).find(params[:id])
    authorize @wiki
    if @wiki.update_attributes(params.require(:wiki).permit(:title, :body, :private))
      redirect_to wiki_path(@wiki), notice: "Your wiki entry has been updated!"
    else
      render "edit"
    end
  end

  ## delete
  def destroy
    @wiki = Wiki.visible_to(current_user).find(params[:id])
    authorize @wiki
    @wiki.destroy
    redirect_to wikis_path, :notice => "Your wiki has been deleted."
  end
end
