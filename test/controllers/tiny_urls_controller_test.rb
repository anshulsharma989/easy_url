require 'test_helper'

class TinyUrlsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tiny_url = tiny_urls(:one)
  end

  test "should get index" do
    get tiny_urls_url
    assert_response :success
  end

  test "should get new" do
    get new_tiny_url_url
    assert_response :success
  end

  test "should create tiny_url" do
    assert_difference('TinyUrl.count') do
      post tiny_urls_url, params: { tiny_url: {  } }
    end

    assert_redirected_to tiny_url_url(TinyUrl.last)
  end

  test "should show tiny_url" do
    get tiny_url_url(@tiny_url)
    assert_response :success
  end

  test "should get edit" do
    get edit_tiny_url_url(@tiny_url)
    assert_response :success
  end

  test "should update tiny_url" do
    patch tiny_url_url(@tiny_url), params: { tiny_url: {  } }
    assert_redirected_to tiny_url_url(@tiny_url)
  end

  test "should destroy tiny_url" do
    assert_difference('TinyUrl.count', -1) do
      delete tiny_url_url(@tiny_url)
    end

    assert_redirected_to tiny_urls_url
  end
end
