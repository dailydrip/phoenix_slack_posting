defmodule SlackPosting.JournalsTest do
  use SlackPosting.DataCase

  alias SlackPosting.Journals

  describe "posts" do
    alias SlackPosting.Journals.Post

    @valid_attrs %{slack_id: "some slack_id", text: "some text"}
    @update_attrs %{slack_id: "some updated slack_id", text: "some updated text"}
    @invalid_attrs %{slack_id: nil, text: nil}

    def post_fixture(attrs \\ %{}) do
      {:ok, post} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Journals.create_post()

      post
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Journals.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Journals.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = Journals.create_post(@valid_attrs)
      assert post.slack_id == "some slack_id"
      assert post.text == "some text"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Journals.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, post} = Journals.update_post(post, @update_attrs)
      assert %Post{} = post
      assert post.slack_id == "some updated slack_id"
      assert post.text == "some updated text"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Journals.update_post(post, @invalid_attrs)
      assert post == Journals.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Journals.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Journals.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Journals.change_post(post)
    end
  end

  describe "comments" do
    alias SlackPosting.Journals.Comment

    @valid_attrs %{slack_id: "some slack_id", text: "some text"}
    @update_attrs %{slack_id: "some updated slack_id", text: "some updated text"}
    @invalid_attrs %{slack_id: nil, text: nil}

    def comment_fixture(attrs \\ %{}) do
      {:ok, comment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Journals.create_comment()

      comment
    end

    test "list_comments/0 returns all comments" do
      comment = comment_fixture()
      assert Journals.list_comments() == [comment]
    end

    test "get_comment!/1 returns the comment with given id" do
      comment = comment_fixture()
      assert Journals.get_comment!(comment.id) == comment
    end

    test "create_comment/1 with valid data creates a comment" do
      assert {:ok, %Comment{} = comment} = Journals.create_comment(@valid_attrs)
      assert comment.slack_id == "some slack_id"
      assert comment.text == "some text"
    end

    test "create_comment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Journals.create_comment(@invalid_attrs)
    end

    test "update_comment/2 with valid data updates the comment" do
      comment = comment_fixture()
      assert {:ok, comment} = Journals.update_comment(comment, @update_attrs)
      assert %Comment{} = comment
      assert comment.slack_id == "some updated slack_id"
      assert comment.text == "some updated text"
    end

    test "update_comment/2 with invalid data returns error changeset" do
      comment = comment_fixture()
      assert {:error, %Ecto.Changeset{}} = Journals.update_comment(comment, @invalid_attrs)
      assert comment == Journals.get_comment!(comment.id)
    end

    test "delete_comment/1 deletes the comment" do
      comment = comment_fixture()
      assert {:ok, %Comment{}} = Journals.delete_comment(comment)
      assert_raise Ecto.NoResultsError, fn -> Journals.get_comment!(comment.id) end
    end

    test "change_comment/1 returns a comment changeset" do
      comment = comment_fixture()
      assert %Ecto.Changeset{} = Journals.change_comment(comment)
    end
  end

  describe "tags" do
    alias SlackPosting.Journals.Tag

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def tag_fixture(attrs \\ %{}) do
      {:ok, tag} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Journals.create_tag()

      tag
    end

    test "list_tags/0 returns all tags" do
      tag = tag_fixture()
      assert Journals.list_tags() == [tag]
    end

    test "get_tag!/1 returns the tag with given id" do
      tag = tag_fixture()
      assert Journals.get_tag!(tag.id) == tag
    end

    test "create_tag/1 with valid data creates a tag" do
      assert {:ok, %Tag{} = tag} = Journals.create_tag(@valid_attrs)
      assert tag.name == "some name"
    end

    test "create_tag/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Journals.create_tag(@invalid_attrs)
    end

    test "update_tag/2 with valid data updates the tag" do
      tag = tag_fixture()
      assert {:ok, tag} = Journals.update_tag(tag, @update_attrs)
      assert %Tag{} = tag
      assert tag.name == "some updated name"
    end

    test "update_tag/2 with invalid data returns error changeset" do
      tag = tag_fixture()
      assert {:error, %Ecto.Changeset{}} = Journals.update_tag(tag, @invalid_attrs)
      assert tag == Journals.get_tag!(tag.id)
    end

    test "delete_tag/1 deletes the tag" do
      tag = tag_fixture()
      assert {:ok, %Tag{}} = Journals.delete_tag(tag)
      assert_raise Ecto.NoResultsError, fn -> Journals.get_tag!(tag.id) end
    end

    test "change_tag/1 returns a tag changeset" do
      tag = tag_fixture()
      assert %Ecto.Changeset{} = Journals.change_tag(tag)
    end
  end
end
