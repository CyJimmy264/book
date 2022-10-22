# frozen_string_literal: true

Given('I am logged in') do
  @email = 'my@email.com'
  @current_user = create(:user, email: @email)
  sign_in @current_user
end
