class User < ActiveRecord::Base

  has_secure_password

  validates :password, presence: true, length: { minimum: 5 }
  validates :password_confirmation, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }

  def self.authenticate_with_credentials(email, password)
    lower_case_email = email.downcase
    user = User.find_by(email: lower_case_email.strip)
    if user && user.authenticate(password)
      return user
    else
      return nil
    end
  end    
end