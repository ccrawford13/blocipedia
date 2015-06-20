class WikisController < ApplicationController

  before_action :find_wiki, except: [:new, :create, :index]

  def index
    @wikis = Kaminari.paginate_array(policy_scope(Wiki)).page(params[:page])
  end

  def show
    @collaborators = @wiki.collaborators
  end

  def new
    @users = User.all
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    @wiki = current_user.wikis.build( wiki_params )
    @user = @wiki.user
    authorize @wiki

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
    @users = User.all
  end

  def update
    @user = @wiki.user

    if @wiki.update_attributes( wiki_params )
      flash[:notice] = "Wiki was successfully updated"
      redirect_to @wiki

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
    authorize @wiki
    @wiki
  end

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private, collaborator_ids:[])
  end
end
