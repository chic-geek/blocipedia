class WikisController < ApplicationController
  def index

  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = List.new(params.require(:wiki).permit(:title))
  end
end
