require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test "cannot save empty post" do
    post = Post.new
    assert !(post.save), "Post fields should not be empty or null"
  end

  test "post text must be at least 50 characters" do
    post = Post.new(  title: "title of > 5 characters",
                      txt: "lol2",
                      time: Time.now,
                      deleted: false,
                      user_id: users(:one),
                      category_id: categories(:category_one))
    assert !(post.save), "Post must be at least 50 characters in length"

    post2 = Post.new(  title: "title of > 5 characters",
                       txt: "This is another string of at least 50 characters (counting spaces too)",
                       time: Time.now,
                       deleted: false,
                       user_id: users(:one),
                       category_id: categories(:category_one))
    assert (post2.save), "Post should save with at least 50 characters of txt"
  end

  test "post title must be at least 5 characters" do
    post = Post.new(  title: "a",
                      txt: "This is another string of at least 50 characters (counting spaces too)",
                      time: Time.now,
                      deleted: false,
                      user_id: users(:one),
                      category_id: categories(:category_one))
    assert !(post.save), "Post title must be at least 5 characters"

    post2 = Post.new(  title: "123456",
                       txt: "This is another string of at least 50 characters (counting spaces too)",
                       time: Time.now,
                       deleted: false,
                       user_id: users(:one),
                       category_id: categories(:category_one))
    assert (post2.save), "Post should save with at least 5 characters of title"
  end

  test "posts must report correct upvote count" do
    post = posts(:post_one)
    post2 = posts(:post_two)
    assert (post.up_vote_count == 2), "Post one should report two upvotes"
    assert (post2.up_vote_count == 0), "Post two should report no upvotes"
  end

  test "posts must report correct comment count" do
    post = posts(:post_one)
    post2 = posts(:post_two)
    assert (post.comments.count == 1), "Post one should report one comment"
    assert (post2.comments.count == 2), "Post two should report two comments"
  end

  test "posts must report correct upvoter" do
    post = posts(:post_one)
    post2 = posts(:post_two)
    user = users(:one)
    assert (post.up_voted?(user)), "User one should have upvoted post one"
    assert !(post2.up_voted?(user)), "User one should not have upvoted post two"
  end

  test "posts should report numerical value properly" do
    post = posts(:post_one)
    post2 = posts(:post_two)
    post_val = post.numerical_value
    post2_val = post2.numerical_value
    assert (post.numerical_value > 0), "Post one should have positive value"
    assert (post2.numerical_value == 0), "Post two should have zero value"
  end

  test "posts should sort properly" do
    post = posts(:post_one)
    post2 = posts(:post_two)
    posts = [post, post2]
    posts.sort!
    assert (posts[0] == post2), "post one should be greater than post two"
  end
end
