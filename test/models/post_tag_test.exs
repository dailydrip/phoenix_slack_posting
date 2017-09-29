defmodule SlackPosting.PostTagTest do
  use SlackPosting.ModelCase

  alias SlackPosting.PostTag

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = PostTag.changeset(%PostTag{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = PostTag.changeset(%PostTag{}, @invalid_attrs)
    refute changeset.valid?
  end
end
