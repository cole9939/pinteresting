class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :pins

<<<<<<< HEAD
  validates :name, presence: true
end
=======
  validates :name, presence: true, :uniqueness => true
  after_create :send_welcome_email

  private
  def send_welcome_email
    UserMailer.welcome_email(self).deliver
  end
end
>>>>>>> f608778c9910d1142e691bce47859a3d1307a15a
