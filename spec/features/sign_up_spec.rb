require 'rails_helper'

describe 'User sign up' do

  describe "successful sign-up" do
    before do
      @user = create(:user)
      @user1 = create(:user)
    end

    it "sends confirmation email following successful sign-up" do

      sign_up_nav

      fill_in "Name", with: @user.name 
      fill_in "Email", with: @user.email
      fill_in "Password", with: @user.password
      fill_in "Password confirmation", with: @user.password_confirmation
      click_button 'Sign up'
      expect( @user.confirmed_at ).not_to be nil
    end
  end

  describe "unsuccessful sign-up" do
    before do
      @user = create(:user)
    end
    
    it "prohibits user from signing up with duplicate email" do

      sign_up_nav

      fill_in "Name", with: @user.name 
      fill_in "Email", with: @user.email
      fill_in "Password", with: @user.password
      fill_in "Password confirmation", with: @user.password_confirmation
      click_button 'Sign up'
      expect( page ).to have_content('Email has already been taken')
    end

    it "prohibits user from signing up with invalid email" do
      
      @user1 = create(:user)

      sign_up_nav

      fill_in "Name", with: @user1.name 
      fill_in "Email", with: 'chad@123'
      fill_in "Password", with: @user1.password
      fill_in "Password confirmation", with: @user1.password_confirmation
      click_button 'Sign up'
      expect( page ).to have_content('Email is invalid')
    end
  end
end

def sign_up_nav
  visit root_path
  within '.user-info' do
    click_link 'Sign Up'
  end
end



