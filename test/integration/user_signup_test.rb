require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest
  test "user signup successfully" do
    get signup_path
    assert_template 'users/new'
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: {username: "emil", email: "emil@emil.ro", password: "password"}
    end
    assert_template 'users/show'
    assert_match "emil", response.body
  end
end