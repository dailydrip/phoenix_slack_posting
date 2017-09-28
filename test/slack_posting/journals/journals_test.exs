defmodule SlackPosting.JournalsTest do
  use SlackPosting.DataCase

  alias SlackPosting.Journals

  describe "posts" do
    alias SlackPosting.Journals.Post

    @valid_attrs %{slack_id: 42, text: "some text"}
    @update_attrs %{slack_id: 43, text: "some updated text"}
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
      assert post.slack_id == 42
      assert post.text == "some text"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Journals.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, post} = Journals.update_post(post, @update_attrs)
      assert %Post{} = post
      assert post.slack_id == 43
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
end
