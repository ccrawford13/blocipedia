require 'rails_helper'

describe 'User sign-in' do

  describe "successful sign-in" do
    before do
      @user = create(:user)
    end

    it "allows confirmed user to sign-in" do

      visit new_user_session_path

      fill_in "Email", with: @user.email
      fill_in "Password", with: @user.password
      click_button "Log in"
      expect( current_path ).to eq(root_path)
    end
  end

  describe "navigation changes to reflect #current_user" do
    before do
      @user = create(:user)
    end

    it "shows #user.name when signed in" do

      visit new_user_session_path

      fill_in "Email", with: @user.email
      fill_in "Password", with: @user.password
      click_button "Log in"
      expect( page ).to have_content(@user.name)
    end

    it "shows link to 'sign-in' when no user is signed in" do
      
      visit root_path
      
      within '.user-info' do
        expect( page ).to have_content("Sign In")
      end
    end
  end
end



