class User < ActiveRecord::Base
  

  has_secure_password
  

  validates :name, presence: true
  validates :email, presence: true, :uniqueness => true
  validates :password, presence: true, :length => {:minimum => 10}
  validates :password_confirmation, presence: true

  before_validation :sanitize_email

  def sanitize_email
    self.email.downcase! 
  end

  def self.authenticate_with_credentials email, password
    @user = User.find_by_email(email.strip.downcase)

    if @user && @user.authenticate(password)
      @user
    else 
      nil
    end

  end

end
