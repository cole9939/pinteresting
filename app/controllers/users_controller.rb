class UsersController < ApplicationController
  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
 
    respond_to do |format|
      if @user.save
        # Tell the UserMailer to send a welcome Email after save
        UserMailer.welcome_email(@user).deliver
 
        format.html { redirect_to(@user, notice: 'User was successfully created.') }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  
  def profile
    @user = User.find_by_name(params[:name])
    @pins = @user.pins.order("created_at DESC") if @user

    unless @user.present?
      redirect_to root_url, notice: "You don't have access to the requested page"
    end
  end
  
end
