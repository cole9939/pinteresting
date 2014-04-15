module PinsHelper

  def web_like(id)
    if Score.find_by_click_on_and_pin_id_and_user_id("website",params[:id],current_user.id).nil?
      return false
    else
      return !Score.find_by_click_on_and_pin_id("website",params[:id]).nil?
    end
  end

  def user_name(pin)
    return User.find(pin).name
  end

  def url(id)
    return User.find(Pin.find(id).user_id).url
  end

  def clicks_of_day
    return !current_user.scores.find(:all, :conditions => { :created_at => Date.today...Date.today+1}).blank?
  end

  def clicks
    !current_user.scores.find(:all, :conditions => { :created_at => Date.today...Date.today+1,:pin_id=>params[:id]}).blank?
  end

  def user_score_day(user)
    Score.find(:all, :conditions => { :created_at => Date.today...Date.today+1 ,:owner_id=>user.id}).count
  end
  
  def user_score_week(user)
    Score.find(:all, :conditions => [" created_at between ? AND ? AND owner_id=?", 1.week.ago, Time.zone.now.beginning_of_day,user.id]).count  
  end
  
  def user_score_month(user)
    Score.find(:all, :conditions => [" created_at between ? AND ? AND owner_id=?", 1.month.ago, Time.zone.now.beginning_of_day,user.id]).count
  end
end
