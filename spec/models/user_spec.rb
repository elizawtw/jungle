require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
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
    it 'must have password_confirmation present' do
      @user = User.new
      @user.first_name = "Mich"
      @user.last_name = "Boyle"
      @user.email = "abcde@xyz.com"
      @user.password = "12345678"
      @user.password_confirmation = nil
      @user.save
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include "Password confirmation can't be blank"
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
    it 'will not save if email using different case' do
      @user1 = User.new
      @user1.first_name = "Mich"
      @user1.last_name = "Boyle"
      @user1.email = "test@test.com"
      @user1.password = "12345678"
      @user1.password_confirmation = "12345678"
      @user1.save
      @user2 = User.new
      @user2.first_name = "Mich"
      @user2.last_name = "Boyle"
      @user2.email = "TEST@TEST.com"
      @user2.password = "12345678"
      @user2.password_confirmation = "12345678"
      @user2.save
      expect(@user1).to be_valid
      expect(@user2.errors.full_messages).to include "Email has already been taken"
    end
    it 'must have first name present' do
      @user = User.new
      @user.first_name = nil
      @user.last_name = "Boyle"
      @user.email = "abcdef@xyz.com"
      @user.password = "12345678"
      @user.password_confirmation = "12345678"
      @user.save
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include "First name can't be blank"
    end  
    it 'must have last name present' do
      @user = User.new
      @user.first_name = "Mich"
      @user.last_name = nil
      @user.email = "abcdef@xyz.com"
      @user.password = "12345678"
      @user.password_confirmation = "12345678"
      @user.save
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include "Last name can't be blank"
    end 
    it 'must have minimum 5 character password' do
      @user = User.new
      @user.first_name = "Mich"
      @user.last_name = "Boyle"
      @user.email = "abcdef@xyz.com"
      @user.password = "123"
      @user.password_confirmation = "123"
      @user.save
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include "Password is too short (minimum is 5 characters)"
    end 
  end

  describe ".authenticate_with_credentials" do
    it 'validates instance of user' do
      @user = User.new
      @user.first_name = "Mich"
      @user.last_name = "Boyle"
      @user.email = "abcdef@xyz.com"
      @user.password = "12345678"
      @user.password_confirmation = "12345678"
      @user.save
      @validate = User.authenticate_with_credentials("abcdef@xyz.com", "12345678")
      expect(@validate).to eq(@user)
      expect(@validate).to be_instance_of(User)
      expect(@validate.email).to eq("abcdef@xyz.com")
      expect(@validate.first_name).to eq("Mich")
    end  
    it 'validates email with spaces' do
      @user = User.new
      @user.first_name = "Mich"
      @user.last_name = "Boyle"
      @user.email = "abcdef@xyz.com"
      @user.password = "12345678"
      @user.password_confirmation = "12345678"
      @user.save
      @validate = User.authenticate_with_credentials(" abcdef@xyz.com ", "12345678")
      expect(@validate).to eq(@user)
      expect(@validate).to be_instance_of(User)
      
    end  
  end  
end
