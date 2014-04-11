class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :pins

  validates :name, presence: true, :uniqueness => true
  after_create :send_welcome_email


  has_reputation :karma,
      :source => { :reputation => :pins_skill, :weight => 0.8 }

  has_reputation :pins_skill,
      :source => { :reputation => :votes, :of => :pins }

  private
  def send_welcome_email
    UserMailer.welcome_email(self).deliver
  end
end
