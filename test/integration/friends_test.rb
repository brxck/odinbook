require "test_helper"

class FriendsTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
    @friend = create(:user)

    sign_in @user
  end

  test "send and cancel friend request" do
    visit user_path(@friend)

    requests = ["@user.reload.friend_requests.size", "@friend.reload.pending_requests.size"]

    assert_difference requests, 1 do
      find("input[id='add-friend']").click
    end

    assert_difference requests, -1 do
      find("input[id='cancel-request']").click
    end
  end
end