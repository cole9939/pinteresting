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

  def score_up
    if params[:type]=="website"
      if Score.find_by_pin_id_and_click_on_and_user_id(params[:pin_id],"website",current_user.id).nil?
        @score= current_user.scores.create(:pin_id=>params[:pin_id].to_i,:click_on=>params[:type],:owner_id=>User.owner_id(params[:pin_id]))
        @pin=Pin.find(params[:pin_id])  
        count=@pin.score+1
        @pin.update_attributes(:score=>count)
      end
    else
      @score= current_user.scores.create(:pin_id=>params[:pin_id].to_i,:click_on=>params[:type],:owner_id=>User.owner_id(params[:pin_id]))
      @pin=Pin.find(params[:pin_id])  
      count=@pin.score+1
      @pin.update_attributes(:score=>count)
    end  
    @web_count=Score.where(:pin_id=>params[:pin_id],:click_on=>"website").count
    respond_to do |format|
      format.js
    end

  end
  def score_down  
    if !Score.find_by_pin_id_and_click_on(params[:pin_id],params[:type]).nil?
      Score.find_by_pin_id_and_click_on(params[:pin_id],params[:type]).delete
      @pin=Pin.find(params[:pin_id])  
      count=@pin.score-1
      @pin.update_attributes(:score=>count)
    end
    @web_count=Score.where(:pin_id=>params[:pin_id],:click_on=>"website").count
    respond_to do |format|
      format.js
    end
  end
  
end
