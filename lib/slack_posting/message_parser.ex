require IEx
defmodule SlackPosting.MessageParser do
  def get_post_information(msg) do
    message = msg.text
    user_slack_id  = msg.user.id
    user_name = msg.user.name
    {message, tags} = extract_message_information(message)
    %{
      user_slack_id: user_slack_id,
      user_name: user_name,
      message: message,
      tags: tags
    }
  end

  def extract_message_information(msg) do
    all_msg = String.split(msg, "$")
    message = extract_msg(all_msg)
    tags = extract_tags(all_msg)
    {message, tags}
  end

  defp extract_tags(all_msg) do
    all_msg
    |> tl
    |> Enum.map(fn x -> String.trim(x) end)
  end

  defp extract_msg(all_msg) do
    all_msg
    |> hd
    |> String.strip
  end

end
