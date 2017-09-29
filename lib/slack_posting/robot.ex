require IEx
defmodule SlackPosting.Robot do
  use Hedwig.Robot, otp_app: :slack_posting

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
    post_information = SlackPosting.MessageParser.get_post_information(msg)
    IEx.pry
    SlackPosting.Journals.create_post(%{
      text: post_information.message,
      user_slack_id: post_information.user_slack_id,
      user_name: post_information.user_name})

    {:dispatch, msg, state}
  end

  def handle_in(_msg, state) do
    {:noreply, state}
  end

end
