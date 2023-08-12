require 'rails_helper'

RSpec.describe 'Testing Devise Page', type: :system do
  describe 'Test Login Page' do
    it 'Test Login url response' do
      get '/users/login'
      assert_response :success
    end
    it "Display 'Login' header" do
      visit '/users/login'
      expect(page).to have_content('Log in')
    end
  end

  describe 'Test Sign Up Page' do
    it "Display 'Sign Up' header" do
      visit '/users/register'
      expect(page).to have_content('Sign up')
    end
  end
  describe 'Test Forgot Password Page' do
    it "Display 'Forgot your password?' Message" do
      visit '/users/password/new'
      expect(page).to have_content('Forgot your password?')
    end
  end
  describe 'Test Confirmation Page' do
    it "Display 'Resend confirmation instructions' Message" do
      visit '/users/verification/new'
      expect(page).to have_content('Resend confirmation instructions')
    end
  end
end
