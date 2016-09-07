require 'test_helper'

class DmItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get dm_items_index_url
    assert_response :success
  end

  test "should get show" do
    get dm_items_show_url
    assert_response :success
  end

  test "should get new" do
    get dm_items_new_url
    assert_response :success
  end

  test "should get edit" do
    get dm_items_edit_url
    assert_response :success
  end

  test "should get delete" do
    get dm_items_delete_url
    assert_response :success
  end

end
