class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :pins
  has_many :scores
  validates :name, presence: true, :uniqueness => true
  after_create :send_welcome_email


  def self.owner_id(pin)
    return Pin.find(pin).user_id
  end  
  
  private
  def send_welcome_email
    UserMailer.welcome_email(self).deliver
  end


end
