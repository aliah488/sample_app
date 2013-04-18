class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user, only: :destroy


  def index
   @users = User.paginate(page: params[:page])
  end

  def show
   @user = User.find(params[:id])
   @microposts = @user.microposts.paginate(page: params[:page])
  end

  def new
   @user = User.new
  end

  def edit
   @user = User.find(params[:id])
  end

  def update
     @user = User.find(params[:id])
     if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
     else
      render 'edit'
     end
  end

  def destroy
     User.find(params[:id]).destroy
     flash[:success] = "User destroyed."
     redirect_to users_url
  end

  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        sign_in @user
        flash[:success] = "Welcome to the Sample App!"
        # redirect_to @user
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        # render 'new'
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private


     def admin_user
       redirect_to(root_path) unless current_user.admin?
     end

     def correct_user
       @user = User.find(params[:id])
       redirect_to(root_path) unless current_user?(@user)
     end
end
