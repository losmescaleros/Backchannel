require 'test_helper'

class UpVoteCommentTest < ActiveSupport::TestCase
  # very boring unit tests
  test "empty upvote comment should not save" do
    upvc = UpVoteComment.new
    assert !(upvc.save), "empty upvote comment should not save"
  end

  test "duplicate upvote comment should not save" do
    upvc = UpVoteComment.new(
        user_id: users(:one),
        comment_id: comments(:comment_one)
    )
    assert !(upvc.save), "duplicate upvote comment should not save"
  end
end
