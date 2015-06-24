require 'test_helper'

class IndexEntriesControllerTest < ActionController::TestCase
  setup do
    @index_entry = index_entries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:index_entries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create index_entry" do
    assert_difference('IndexEntry.count') do
      post :create, index_entry: { common_name: @index_entry.common_name, family: @index_entry.family, latin_name: @index_entry.latin_name }
    end

    assert_redirected_to index_entry_path(assigns(:index_entry))
  end

  test "should show index_entry" do
    get :show, id: @index_entry
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @index_entry
    assert_response :success
  end

  test "should update index_entry" do
    patch :update, id: @index_entry, index_entry: { common_name: @index_entry.common_name, family: @index_entry.family, latin_name: @index_entry.latin_name }
    assert_redirected_to index_entry_path(assigns(:index_entry))
  end

  test "should destroy index_entry" do
    assert_difference('IndexEntry.count', -1) do
      delete :destroy, id: @index_entry
    end

    assert_redirected_to index_entries_path
  end
end
