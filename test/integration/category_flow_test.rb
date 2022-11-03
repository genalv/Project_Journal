require "test_helper"

class CategoryFlowTest < ActionDispatch::IntegrationTest
  setup do
    @category = categories(:one)
    @task = tasks(:one)
    sign_in users(:one)
  end

  test "user can not see home page without login" do 
    get "/"
    assert 302, status 
  end
  
  # test "registration" do
  #   get new_user_registration_url
  #   assert_select 'a', "Sign up", 2
  #   assert_select 'a', "Log in", 1
  #   assert_select 'a', "Home", 1
  #   assert_select 'a', "Sign in", 1
  # end

  # test "sign in" do
  #   get new_user_session_url
  #   assert_select 'a', "Sign up", 2
  #   assert_select 'a', "Home", 1
  #   assert_select 'a', "Sign in", 1
  #   assert_select 'a', "Forgot your password?", 1
  # end

  test "create category" do
    get new_category_url
    assert_response :success
    
    post categories_url,
      params: { category: { title: "can create", details: "category successfully."}}
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "td", "can create", match: :first 
    assert_select "td", "category successfully.", match: :second
  end

  test "categories page" do
    get root_url
    assert_select "td", "CategoryOne", match: :first
    assert_select "td", "DetailsOne", match: :second
    # assert_select "td", "CategoryGene", match: :first
    # assert_select "td", "DetailsGene", match: :second
    # assert_select "td", "can create", match: :third
    # assert_select "td", "category successfully.", match: :fourth
    # click_link "Show Tasks", match: :first
  end


    # test "sign up" do
    #   get  new_user_registration_path
    #   assert_response :success

    #   post new_user_registration_path,
    #     params: {users: { email: "test12345@test.com", password:"123456", password:"123456" }}
    #   assert_response :redirect
    #   follow_redirect!
    #   assert_response :success
    # end

    test "sign out" do
      get root_url
      assert_response :success

      delete destroy_user_session_url
      assert_response :redirect
      follow_redirect!
      assert_response :redirect
    end

    # test "edit profile" do
    #   get root_url
    #   assert_response :success
      
    #   get edit_user_registration_url,
    #     params: {user: { email: "qwe123@test.com", password: "1234567", password: "1234567", password: "123456"}}
    #   assert_response :redirect
    #   follow_redirect!
    # end

    test "view category/tasks" do
      get category_url(@category)
      assert_response :success

      assert_select "td", "TaskOne", match: :first
      assert_select "td", "TDetailOne", match: :second

      assert_select "a", "Edit", match: :first 
      assert_select "a", "Destroy", match: :second
      assert_select "a", "Back", match: :third
    end

    test "edit category" do
      get categories_url
      assert_response :success
      
      patch category_url(@category),
        params: { category: { title: "can edit", details: "category successfully."}}
      assert_response :redirect
      follow_redirect!
      assert_response :success
      assert_select "td", "can edit", match: :first 
      assert_select "td", "category successfully.", match: :second
    end

    # test "edit task" do
    #   get category_url(@category)
    #   assert_response :success

    #   patch category_task_url(@task),
    #     params: { task: { title: "can edit", details: "task successfully." }}
    #   assert_response :redirect
    #   follow_redirect!
    #   assert_response :success
    #   assert_select
    # end

    # test "view category" do
    #   get categories_url
      
    #   assert_select "a", "Edit Category/Show Tasks", match: :first

    #   get category_url(@category)
    #   assert_select "a", "Edit", match: :first 
    #   assert_select "a", "Destroy", match: :second
    #   assert_select "a", "Back", match: :third
    # end

    test "create task" do
      get category_url(@category)
      assert_response :success

      post category_task_url(@category),
        params: { task: { title: "can create", details: "tasks successfully." }}
      assert_response :redirect
      follow_redirect!
      assert_response :success
    end
end

