require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user = User.create(name: "Appa",
                        email: "appa@cat.net",
                        password: "testing",
                        password_confirmation: "testing")

    @friend = User.create(name: "Tori",
                          email: "jensen@ackles.net",
                          password: "testing",
                          password_confirmation: "testing")

    @user.friends << @friend
  end

  test "default profile" do
    assert @user.profile
  end

  test "friends list" do
    assert_includes @user.friends, @friend
  end
end
