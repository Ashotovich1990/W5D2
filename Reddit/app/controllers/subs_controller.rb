class SubsController < ApplicationController
  before_action :require_login

  def new 
    :new
  end

  def create 
    @sub = Sub.new(sub_params)
    @sub.user_id = current_user.id

    if @sub.save 
      redirect_to sub_url(@sub)
    else 
      flash.now[:erros] = @sub.errors.full_messages 
      render :new
    end
  end

  def index 
    @subs = Sub.all 
  end 

  def show 
    @sub = Sub.find_by(id: params[:id])
  end

  def edit 
    @sub = Sub.find_by(id: params[:id])
  end
   
  def update 
   
    @sub = Sub.find_by(id: params[:id])

    if @sub.moderator == current_user
      if @sub.update(sub_params)
        redirect_to sub_url(@sub)
      else  
        flash.now[:erros] = @sub.errors.full_messages 
        render :edit 
      end 
    else  
      render json: "Not Your Sub to Edit!" 
    end
  end

  private 

  def sub_params 
    params.require(:sub).permit(:title, :description)
  end
end
