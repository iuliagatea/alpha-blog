require 'test_helper'

class CreateArticlesTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.create(username: "emil", email: "emil@emil.ro", password: "password", admin: true)
  end

  test "create articles" do
    sign_in_as(@user, "password")
    get new_article_path 
    assert_template 'articles/new' 
    assert_difference 'Article.count', 1 do 
      post_via_redirect articles_path, article: {title: "sports", description: "this is the description", user: @user}
    end
    assert_template 'articles/show' 
    assert_match "sports", response.body 
  end
end