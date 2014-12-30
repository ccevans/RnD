require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get lyriclab" do
    get :lyriclab
    assert_response :success
  end

end
