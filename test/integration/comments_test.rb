require 'test_helper'

class CommentsTest < ActionDispatch::IntegrationTest
  def setup
    @post = create(:post)
    @user = create(:user_with_posts)

    sign_in @user
  end
end
