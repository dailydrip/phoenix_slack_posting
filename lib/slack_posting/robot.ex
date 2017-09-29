defmodule SlackPosting.Robot do
  use Hedwig.Robot, otp_app: :slack_posting
  alias SlackPosting.{
    Journals,
    MessageParser
  }

  def handle_connect(%{name: name} = state) do
    if :undefined == :global.whereis_name(name) do
      :yes = :global.register_name(name, self())
    end

    {:ok, state}
  end

  def handle_disconnect(_reason, state) do
    {:reconnect, 5000, state}
  end

  def handle_in(%Hedwig.Message{} = msg, state) do
    post_information = MessageParser.get_post_information(msg)
    {_, post} = Journals.create_post(%{
      text: post_information.message,
      user_slack_id: post_information.user_slack_id,
      user_name: post_information.user_name})
    create_tags(post_information.tags, post)

    {:dispatch, msg, state}
  end

  def create_tags(tags, post) do
    for tag <- tags do
      the_tag = Journals.find_or_create_tag_by_name(tag)

      Journals.create_post_tag(%{post_id: post.id, tag_id: the_tag.id})
    end
  end

  def handle_in(_msg, state) do
    {:noreply, state}
  end
end
