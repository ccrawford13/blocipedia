require 'rails_helper'

describe 'User sign up' do

  describe "successful sign-up" do

    it "sends confirmation email following successful sign-up" do
      before do
        @user = create(:user)
      end

      visit root_path
      within '.user-info' do
        click_link 'Sign Up'
      end
      fill_in "Name", with: @user.name 
      fill_in "Email", with: @user.email
      fill_in "Password", with: @user.password
      fill_in "Password confirmation", with: @user.password_confirmation
      click_button 'Sign up'
      expect(@user.confirmation_sent_at).to eq(Time.now)
    end

    describe "unsuccessful sign-up" do
      

  end
end



