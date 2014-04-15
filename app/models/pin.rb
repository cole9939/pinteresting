class Pin < ActiveRecord::Base
  belongs_to :user
  has_many :scores
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  validates :image, presence: true
  validates :description, presence: true

  def self.score_of_day
    pin_scores_day=Score.find(:all, :conditions => { :created_at => Date.today...Date.today+1 })
    pin_scores_day=pin_scores_day.collect(& :owner_id)
    count = Hash.new(0)
    pin_scores_day.each do |v|
      count[v] += 1
    end

    pins_scores_day = Hash[count.sort_by{|k, v| v}.reverse]
    pin_users=[]
    pins_scores_day.keys.each do |id|
      pin_users<<User.find(id)
    end
    return pin_users 
  end

  def self.score_of_week
    pin_scores_week=Score.find(:all, :conditions => [" created_at between ? AND ?", 1.week.ago, Time.zone.now.beginning_of_day])
    pin_scores_week=pin_scores_week.collect(& :owner_id)
    count = Hash.new(0)
    pin_scores_week.each do |v|
      count[v] += 1
    end
    pin_scores_week = Hash[count.sort_by{|k, v| v}.reverse]
    pin_users=[]
    pin_scores_week.keys.each do |id|
      pin_users<<User.find(id)
    end
    return pin_users 
  end

  def self.score_of_month
    pin_scores_month=Score.find(:all, :conditions => [" created_at between ? AND ?", 1.month.ago, Time.zone.now.beginning_of_day])
    pin_scores_month=pin_scores_month.collect(& :owner_id)
    count = Hash.new(0)
    pin_scores_month.each do |v|
      count[v] += 1
    end
    pin_scores_month = Hash[count.sort_by{|k, v| v}.reverse]
    pin_users=[]
    pin_scores_month.keys.each do |id|
      pin_users<<User.find(id)
    end
    return pin_users 
  end
end
