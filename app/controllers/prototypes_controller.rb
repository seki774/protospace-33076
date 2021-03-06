class PrototypesController < ApplicationController
  before_action :set_prototype, except: [:index, :new, :create]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :contributor_confirmation, only: [:edit, :update, :destroy]

  def index
    @prototypes = Prototype.includes(:user)
  end

  def new
    @prototypes = Prototype.new
  end

  def create
    @prototypes = Prototype.new(prototype_params)
    if @prototypes.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @prototypes.comments
  end

  def destroy
    if @prototypes.destroy
          redirect_to root_path
    else
          redirect_to root_path
    end
  end

  def edit
  end
  
  def update
    if @prototypes.update(prototype_params)
         redirect_to prototype_path(@prototypes)
    else
      render :edit
    end
  end
 
    private
  def prototype_params
 
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def set_prototype
    @prototypes = Prototype.find(params[:id])
  end

  def contributor_confirmation
    redirect_to root_path unless current_user == @prototypes.user
  end
end