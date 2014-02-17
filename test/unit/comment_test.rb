require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test "cannot save empty comment" do
    com = Comment.new
    assert !(com.save), "empty comment should not be able to be saved"
  end

  test "comments must be of length >10" do
    com = Comment.new(
        time: Time.now,
        txt: "a",
        post_id: posts(:post_one),
        user_id: users(:one)
    )
    com2 = Comment.new(
        time: Time.now,
        txt: "This is a comment of at least length 10",
        post_id: posts(:post_one),
        user_id: users(:one)
    )

    assert !(com.save), "comments of length <10 should not save"
    assert (com2.save), "comments of length 10 < x < 60000 should save"
  end

  test "comment should report correct upvote" do
    com = comments(:comment_one)
    com2 = comments(:comment_two)
    assert (com.up_vote_count == 2), "comment one should report 2 upvotes"
    assert (com2.up_vote_count == 0), "comment two should report 0 upvotes"
  end

  test "comment should report correct upvoter" do
    com = comments(:comment_one)
    com2 = comments(:comment_two)
    user = users(:one)
    assert (com.up_voted?(user)), "user one should have upvoted comment one"
    assert !(com2.up_voted?(user)), "user one should not have upvoted"
  end
end
