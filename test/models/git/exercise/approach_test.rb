require 'test_helper'

class Git::Exercise::ApproachTest < ActiveSupport::TestCase
  test "content" do
    approach = Git::Exercise::Approach.new("readability", "hamming", "practice", "HEAD",
      repo_url: TestHelpers.git_repo_url("track-with-exercises"))

    assert_equal "# Description\n\nReadability approach", approach.content
  end

  test "content file path" do
    approach = Git::Exercise::Approach.new("readability", "hamming", "practice", "HEAD",
      repo_url: TestHelpers.git_repo_url("track-with-exercises"))
    assert_equal('content.md', approach.content_filepath)
  end

  test "content absolute file path" do
    approach = Git::Exercise::Approach.new("readability", "hamming", "practice", "HEAD",
      repo_url: TestHelpers.git_repo_url("track-with-exercises"))
    assert_equal('exercises/practice/hamming/.approaches/readability/content.md', approach.content_absolute_filepath)
  end

  test "snippet" do
    approach = Git::Exercise::Approach.new("readability", "hamming", "practice", "HEAD",
      repo_url: TestHelpers.git_repo_url("track-with-exercises"))

    assert_equal "READABILITY", approach.snippet
  end

  test "snippet file path" do
    approach = Git::Exercise::Approach.new("readability", "hamming", "practice", "HEAD",
      repo_url: TestHelpers.git_repo_url("track-with-exercises"))
    assert_equal('snippet.txt', approach.snippet_filepath)
  end

  test "snippet absolute file path" do
    approach = Git::Exercise::Approach.new("readability", "hamming", "practice", "HEAD",
      repo_url: TestHelpers.git_repo_url("track-with-exercises"))
    assert_equal('exercises/practice/hamming/.approaches/readability/snippet.txt', approach.snippet_absolute_filepath)
  end
end
