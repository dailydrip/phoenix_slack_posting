defmodule SlackPosting.MessageParserTest do
  use SlackPosting.DataCase

  alias SlackPosting.Journals
  alias SlackPosting.MessageParser, as: Parser

  describe "#get_post" do
    @msg %{matches: nil, private: %{},
      ref: "Reference<0.1942338743.3794796545.160176>", robot: "#PID<0.452.0>",
      room: "C7A445BS5", text: "my message $tag1 $tag2", type: "message",
      user: %Hedwig.User{id: "U2TD8S7ME", name: "franzejr"}}

    @expected_post_information  %{
      message: "my message",
      tags: ["tag1", "tag2"],
      user_name: "franzejr",
      user_slack_id: "U2TD8S7ME"}

    test "returns a tuple with message and tags" do
      post_information = Parser.get_post_information(@msg)
      assert post_information == @expected_post_information
    end
  end

  describe "#extract_message_information" do
    @msg "my message $tag1 $tag2"

    test "returns a tuple with message and tags" do
      returned_value = Parser.extract_message_information(@msg)
      assert returned_value == {"my message", ["tag1", "tag2"]}
    end
  end
end
