require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.create(username: "emil", email: "emil@emil.ro", password: "password", admin: true)
  end

  test "get new category form and create category" do
    sign_in_as(@user, "password")
    get new_category_path #going to new category path
    assert_template 'categories/new' #getting new form
    assert_difference 'Category.count', 1 do #posting new form creating category sports
      post_via_redirect categories_path, category: {name: "sports"}
    end
    assert_template 'categories/index' #redirecting to index page
    assert_match "sports", response.body #index page should have sports now that we created a category sports displayed in the page
  end
  
  test "invalid category submission results in failure" do
    sign_in_as(@user, "password")
    get new_category_path #going to new category path
    assert_template 'categories/new' #getting new form
    assert_no_difference 'Category.count' do #verify the difference in category count
      post categories_path, category: {name: " "}
    end
    assert_template 'categories/new' #redirecting to new page
    assert_select 'h2.panel-title' #looking for the existence of these errors containter
    assert_select 'div.panel-body'
  end
end