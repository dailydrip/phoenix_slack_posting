defmodule SlackPosting.RobotTest do
  use SlackPosting.DataCase
  alias SlackPosting.Journals

  test "creates messages if they contain tags" do
    message =
      create_message("josh", "foo $js")

    SlackPosting.Robot.handle_in(message, %{})

    assert Journals.get_post_by_slack_id(message.private[:msg]["ts"])
  end

  test "creates messages if tagged in a thread" do
    message =
      create_message("josh", "foo")

    # This doesn't store the message in the db, but it will keep it in the
    # cache
    SlackPosting.Robot.handle_in(message, %{})

    reply =
      create_reply(message, "franzejr", "$js")

    # Now we're tagging a message we ignored previously, so we'll fetch it from
    # the cache and store it then store the reply or tag it appropriately
    SlackPosting.Robot.handle_in(reply ,%{})

    assert post = Journals.get_post_by_slack_id(message.private[:msg]["ts"])

    post = Repo.preload(post, :tags)
    tag_names =
      Enum.map(post.tags, &(&1.name))

    assert tag_names == ["js"]
  end

  def create_message(username, text) do
    %Hedwig.Message{
      private: %{
        msg: %{
         "text" => text,
         "ts" => Ecto.UUID.generate(),
         "type" => "message",
         "user" => username}
      },
      ref: make_ref(),
      text: text,
      type: "message",
      user: %Hedwig.User{id: username, name: username}
    }
  end

  def create_reply(message, username, text) do
    %Hedwig.Message{
      private: %{
        msg: %{
         "text" => text,
         "thread_ts" => message.private[:msg]["ts"],
         "ts" => Ecto.UUID.generate(),
         "type" => "message",
         "user" => username}
      },
      ref: make_ref(),
      text: text,
      type: "message",
      user: %Hedwig.User{id: username, name: username}
    }
  end
end
