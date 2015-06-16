require 'test_helper'

class PollenImagesControllerTest < ActionController::TestCase
  setup do
    @pollen_image = pollen_images(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pollen_images)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pollen_image" do
    assert_difference('PollenImage.count') do
      post :create, pollen_image: { tags: @pollen_image.tags }
    end

    assert_redirected_to pollen_image_path(assigns(:pollen_image))
  end

  test "should show pollen_image" do
    get :show, id: @pollen_image
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pollen_image
    assert_response :success
  end

  test "should update pollen_image" do
    patch :update, id: @pollen_image, pollen_image: { tags: @pollen_image.tags }
    assert_redirected_to pollen_image_path(assigns(:pollen_image))
  end

  test "should destroy pollen_image" do
    assert_difference('PollenImage.count', -1) do
      delete :destroy, id: @pollen_image
    end

    assert_redirected_to pollen_images_path
  end
end
