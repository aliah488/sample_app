class UsersController < ApplicationController

  def show
   @user = User.find(params[:id])
  end

  def new
   @user = User.new
  end

  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
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
end
