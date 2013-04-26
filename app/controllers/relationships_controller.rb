class RelationshipsController < ApplicationController
  before_filter :signed_in_user

  # Exercise 11.5.2 replacing respond_to with respond_with
  respond_to :html, :js

  def create
     @user = User.find(params[:relationship][:followed_id])
     current_user.follow!(@user)
     
     # Exercise 11.5.2 replacing respond_to with respond_with
     respond_with @user
     # respond_to do |format|
     #   format.html { redirect_to @user }
     #   format.js
      # end
  end

  def destroy
     @user = Relationship.find(params[:id]).followed
      current_user.unfollow!(@user)

      # Exercise 11.5.2 replacing respond_to with respond_with
      respond_with @user
      # respond_to do |format|
      #  format.html { redirect_to @user }
      #  format.js
      # end
  end
end


