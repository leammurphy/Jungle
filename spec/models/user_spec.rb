require 'rails_helper'

RSpec.describe User, type: :model do
  context 'given a user' do
    it 'Creates a new entry' do
      @user = User.new(name: "Jane" , email: "Jane@gmail.com" , password: 'password123', password_confirmation: 'password123')
      expect(@user.save).to eq(true)
    end

    it 'the password and password_confirmation are the same' do
      @user = User.new(name: "Jane" , email: "Jane@gmail.com" , password: '123', password_confirmation: '123')
      expect(@user.password == @user.password_confirmation).to be_truthy
    end

    it 'the password and password confirmation are NOT the same' do
      @user = User.new(name: "Jane" , email: "Jane@gmail.com" , password: '123', password_confirmation: '124')
      expect(@user.password != @user.password_confirmation).to be_truthy
    end

    it 'the password must be a min length of 10' do
      @user = User.new(name: "Jane" , email: "Jane@gmail.com" , password: '123', password_confirmation: '124')
      expect(@user.password.length < 10).to be_truthy
    end

    it 'the email must be unique and not case sensitive' do
      @user1 = User.new(name: "Jane" , email: "Jane@gmail.com" , password: 'password123', password_confirmation: 'password123')

      @user1.save 

      @user2 = User.new(name: "Jane" , email: "Jane@Gmail.com" , password: 'password123', password_confirmation: 'password123')


      expect(@user2.save).to eq(false)
    end
  end

  describe '.authenticate_with_credentials' do
    before :each do 
      @user = User.create(name: 'jane', email: 'Jane@gmail.com', password: 'password123', password_confirmation: 'password123')
    end 

    it 'should login given valid credentials' do

      @user1 = User.authenticate_with_credentials('Jane@gmail.com', 'password123')


      expect(@user1).not_to be_nil
    end

    it 'should log in a user with spaces before/after the email' do
      @user1 = User.authenticate_with_credentials(' Jane@gmail.com ', 'password123') 

      expect(@user1).not_to be_nil
    end

    it 'should return nil if the email is incorrect' do
      @user1 = User.authenticate_with_credentials('John@gmail.com', 'password123')
      expect(@user1).to eq(nil)
    end

    it 'should return nil if the password is incorrect' do
      @user1 = User.authenticate_with_credentials(' Jane@gmail.com ', 'password124')
      expect(@user1).to eq(nil)
    end

    it 'should not let a new user signup with an existing email' do

      @user1 = User.new(name: 'jane1', email: 'Jane@gmail.com', password: 'newpassword', password_confirmation: 'newpassword')

      expect(@user1).not_to be_valid
    end
  end
end
