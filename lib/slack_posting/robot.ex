defmodule SlackPosting.Robot do
  use Hedwig.Robot, otp_app: :slack_posting
  alias SlackPosting.{Journals, MessageParser}

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
    Cachex.set(:messages, post_information.slack_id, post_information)

    if Enum.any?(post_information.tags) do
      if post_information.in_reply_to_slack_id do
        case Journals.get_post_by_slack_id(post_information.in_reply_to_slack_id) do
          nil ->
            # See if we have the original message in our cache
            case Cachex.get(:messages, post_information.in_reply_to_slack_id) do
              {:missing, _} ->
                # No dice
                :ok

              {:ok, original_post} ->
                # we have it. create the post
                {:ok, post} = create_post(original_post)
                # then tag it
                create_tags(post_information.tags, post)
                # then create this comment
                if post_information.message !== "" do
                  {:ok, _comment} = create_comment(post, post_information)
                end

              # then create this comment
              post ->
                create_tags(post_information.tags, post)
                if post_information.message !== "" do
                  {:ok, _comment} = create_comment(post, post_information)
                end
            end
        end
      else
        unless post_information.message == "" do
          {:ok, post} = create_post(post_information)
          create_tags(post_information.tags, post)
        end
      end

      {:dispatch, msg, state}
    end
  end

  def handle_in(_msg, state) do
    {:noreply, state}
  end

  def create_tags(tags, post) do
    for tag <- tags do
      the_tag = Journals.find_or_create_tag_by_name(tag)

      Journals.create_post_tag(%{post_id: post.id, tag_id: the_tag.id})
    end
  end

  def create_post(post_information) do
    Journals.create_post(%{
      text: post_information.message,
      user_slack_id: post_information.user_slack_id,
      slack_id: post_information.slack_id,
      user_name: post_information.user_name
    })
  end

  def create_comment(post, comment_post_information) do
    Journals.create_comment(%{
      text: comment_post_information.message,
      slack_id: comment_post_information.slack_id,
      post: post
    })
  end
end
