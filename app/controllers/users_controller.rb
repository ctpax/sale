class UsersController < ApplicationController
  before_action :authenticate_user, only: [:index, :edit, :show]
  respond_to :json, :html

 def show
  set_user
 end

  def edit
    current_user
  end

  def new
  	@user = User.new
  end

  def index 
      #request shopsense api through model method, store response in @import variable 
      @imports = Product.party(params[:limit], params[:category], params[:search])
      #build jason base on the user who logged in
      respond_with current_user
  end

  def create
    @user = User.new(user_params)
      if @user.save
        respond_to do |format|
          format.html { redirect_to (users_path)}
          format.json { render json: @user, status: :created}
        end
      else
        respond_to do |format|
          format.html { render 'new' }
          #specify http rsponse code when create action fails
          format.json { render json: @user.errors, status: :unprocessable_entity}
        end
      end
  end

  def update
    if current_user.update_attributes(user_params)
       respond_to do |format|
          format.html { redirect_to users_path }
          format.json { render nothing: true, status: :no_content}
        end
      else
        respond_to do |format|
          format.html { render 'edit' }
          #specify http rsponse code when update action fails
          #json redner errors message
          format.json { render json: @user.errors, status: :unprocessable_entity}
        end
    end
  end

  def destroy
    current_user.destroy
    respond_to do |format|
      format.html { redirect_to users_path }
      format.json { render json: { head: :ok } }
    end
  end 

  protected
  #find the user in the data if id is in the parameters
  def set_user
    @user = User.find(params[:id])
  end
  #specify what info is safe to pass into the database
  def user_params
    params.require(:user).permit(:username, :name, :email, :password, :password_confirmation)
  end
end
