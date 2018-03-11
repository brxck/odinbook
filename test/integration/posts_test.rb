require 'test_helper'

class PostsTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:user)
    sign_in @user
  end

  test "post lifecycle" do
    visit root_url

    # Post creation
    fill_in "post-body-field", with: "Hello world!"
    fill_in "post-link-field", with: "http://helloworld.com"
    click_button "post-submit-button"

    assert_text "Hello world!"
    assert_link "http://helloworld.com"

    # Post editing
    click_link "post-edit-button"
    fill_in "post-body-field", with: "Goodbye cruel world!"
    fill_in "post-link-field", with: "http://good.bye"
    click_button "Save"

    assert_text "Goodbye cruel world!"
    assert_link "http://good.bye"

    # Post deletion
    click_link "post-delete-button"
    assert_no_text "Goodbye cruel world!"
  end

  test "post validations and flash" do
    visit root_url

    fill_in "post-link-field", with: "I'm a confused user."
    click_button "post-submit-button"

    flash = find_by_id("flash")
    flash.assert_text("Body")
    flash.assert_text("Link")
  end

  test "post authorization" do
    @other_user = create(:user_with_posts)

    visit edit_post_path(@other_user.posts.first)
    find_by_id("flash").assert_text("You cannot")

    assert_no_difference "@other_user.reload.posts.count" do
      # Kind of hacky way to get Capybara to send a delete request.
      page.driver.delete url_for(@other_user.posts.first)
    end
  end
end
