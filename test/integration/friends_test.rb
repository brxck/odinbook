require "test_helper"

class FriendsTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
    @friend = create(:user)

    sign_in @user
  end

  test "send and cancel friend request" do
    visit url_for(@friend)

    # Test that friend requests and notification are generated
    effects = ["@user.reload.friend_requests.size",
               "@friend.reload.pending_requests.size",
               "@friend.notifications.size"]

    # Send request
    assert_difference effects, 1 do
      click_link("add-friend")
    end

    # Cancel request
    assert_difference effects, -1 do
      click_link("cancel-request")
    end
  end
end
