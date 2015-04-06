class WikisController < ApplicationController

  before_action :find_wiki, except: [:new, :create]

  def show
  end

  def new
    @wiki = Wiki.new
  end
  
  def create
    @wiki = current_user.wikis.build( wiki_params )
    @user = @wiki.user

    if @wiki.save
      flash[:notice] = "Wiki was sucessfully created"
      redirect_to @user
    else
      flash[:error] = "Wiki could not be saved, please try again"
      render :new
    end
  end

  def edit
    @user = @wiki.user
  end

  def update
    @user = @wiki.user

    if @wiki.update_attributes( wiki_params )
      flash[:notice] = "Wiki was successfully updated"
      redirect_to @user
    else
      flash[:error] = "Wiki could not be updated, please try again"
      render :edit
    end
  end

  def destroy
    @user = @wiki.user

    if @wiki.destroy
      flash[:notice] = "Wiki was successfully deleted"
      redirect_to @user
    else
      flash[:error] = "Wiki could not be deleted, please try again"
      redirect_to @user
    end
  end


  private

  def find_wiki
    @wiki = Wiki.find(params[:id])
    @wiki
  end

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
end
