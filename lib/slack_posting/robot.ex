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
    text = msg.text
    slack_id  = msg.user.id
    create_post_if_necessary(text, slack_id)
    {:dispatch, msg, state}
  end

  def handle_in(_msg, state) do
    {:noreply, state}
  end

  def create_post_if_necessary(text, slack_id) do
    if String.contains?(text, "$") do
      SlackPosting.Journals.create_post(%{text: text, slack_id: slack_id})
    end
  end
end
