require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation' do
    it 'should validate if all fields are present' do
      @user = User.new
      @user.first_name = "Mich"
      @user.last_name = "Boyle"
      @user.email = "abcde@xyz.com"
      @user.password = "12345678"
      @user.password_confirmation = "12345678"
      @user.save
      expect(@user).to be_valid
    end 
    it 'must have a password fields' do
      @user = User.new
      @user.first_name = "Mich"
      @user.last_name = "Boyle"
      @user.email = "abcde@xyz.com"
      @user.password = nil
      @user.password_confirmation = "12345678"
      @user.save
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include "Password can't be blank"
    end
    it 'must have same password and password_confirmation present' do
      @user = User.new
      @user.first_name = "Mich"
      @user.last_name = "Boyle"
      @user.email = "abcde@xyz.com"
      @user.password = "12345678"
      @user.password_confirmation = "password"
      @user.save
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
    end
    it 'will not save if email is nil' do
      @user = User.new
      @user.first_name = "Mich"
      @user.last_name = "Boyle"
      @user.email = nil
      @user.password = "12345678"
      @user.password_confirmation = "12345678"
      @user.save
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include "Email can't be blank"
    end  
  end
end
