require 'test_helper'

class ReactionsTest < ActionDispatch::IntegrationTest
  def setup
    @post = create(:post)
    @user = create(:user)

    sign_in @user
  end

  test "post reactions" do
    visit url_for(@post)

    # Test that friend requests and notification are generated
    effects = ["@post.reload.reactions.size",
               "@post.user.reload.notifications.size",
               "@user.reload.reactions.size"]

    # Add reaction
    assert_difference effects, 1 do
      click_link("Bless")
    end

    # Remove reaction
    assert_difference effects, -1 do
      click_link("Bless")
    end
  end
end
