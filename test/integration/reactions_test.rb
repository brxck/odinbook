require "test_helper"

class ReactionsTest < ActionDispatch::IntegrationTest
  def setup
    @post = create(:post)
    @user = create(:user_with_posts)

    sign_in @user
  end

  test "post reactions" do
    visit url_for(@post)

    effects = ["@post.reload.reactions.size",
               "@post.user.reload.notifications.size",
               "@user.reload.reactions.size"]

    # Add reaction
    assert_difference effects, 1 do
      click_link("smite-post-button")
    end

    # Remove reaction
    assert_difference effects, -1 do
      click_link("smite-post-button")
    end
  end

  test "own post reactions" do
    @own_post = @user.posts.first
    visit url_for(@own_post)

    effects = ["@own_post.reload.reactions.size",
               "@user.reload.reactions.size"]

    # Don't receive notifications for reacting to your own post.
    assert_difference effects, 1 do
      assert_no_difference "@user.reload.notifications.size" do
        click_link("bless-post-button")
      end
    end
  end
end
