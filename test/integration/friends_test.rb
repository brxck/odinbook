require "test_helper"

class FriendsTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
    @friend = create(:user)

    sign_in @user
  end

  test "send and cancel friend request" do
    visit user_path(@friend)

    assert_difference "@user.reload.friend_requests.size", 1 do
      assert_difference "@friend.reload.pending_requests.size", 1 do
        find("input[id='add-friend']").click
      end
    end

    assert_difference "@user.reload.friend_requests.size", -1 do
      assert_difference "@friend.reload.pending_requests.size", -1 do
        find("input[id='cancel-request']").click
      end
    end
  end
end