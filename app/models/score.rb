class Score < ActiveRecord::Base
  belongs_to :pin
  belongs_to :user
  after_create :user_id,:pin_id
end
