require 'test_helper'

class UpVotePostTest < ActiveSupport::TestCase
  # very boring unit tests
  test "empty upvote post should not save" do
    upvp = UpVotePost.new
    assert !(upvp.save), "empty upvote post should not save"
  end

  test "duplicate upvote post should not save" do
    upvp = UpVotePost.new(
        user_id: users(:one),
        post_id: posts(:post_one)
    )
    assert !(upvp.save), "duplicate upvote post should not save"
  end
end
