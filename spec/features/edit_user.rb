require 'rails_helper'

describe "Edit user attributes" do

  describe "change user password" do
    before do
      @user = create(:user)

      #Sign in User
      visit new_user_session_path

      fill_in "Email", with: @user.email
      fill_in "Password", with: @user.password
      click_button "Log in"
      expect( current_path ).to eq(root_path)
      visit edit_user_registration_path
    end

    it "is not updated without current password" do

      fill_in "Password", with: 'newpassword'
      fill_in "Password confirmation", with: 'newpassword'
      click_button "Update"
      expect( page ).to have_content("Current password can't be blank")
    end

    it "is not updated if 'password confirmation' does not mach password" do

      fill_in "Password", with: 'newpassword'
      fill_in "Password confirmation", with: 'password'
      fill_in "Current password", with: @user.password
      click_button "Update"
      expect( page ).to have_content("Password confirmation doesn't match Password")
    end

    it "is not updated if password is shorter than 8 characters" do

      fill_in "Password", with: 'word'
      fill_in "Password confirmation", with: 'word'
      fill_in "Current password", with: @user.password
      click_button "Update"
      expect( page ).to have_content("Password is too short")
    end

    it "updates password with all fields correctly entered" do
      fill_in "Password", with: 'newpassword'
      fill_in "Password confirmation", with: 'newpassword'
      fill_in "Current password", with: @user.password
      click_button "Update"
      expect( current_path ).to eq(root_path) #I'd like to test expect( flash[:notice] ).to eq "User was updated successfully"
    end

  end
end

