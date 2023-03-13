defmodule DiscussWeb.TopicHTML do
  use DiscussWeb, :html

  embed_templates("topic_html/*")

  attr(:test_content, :string)

  def testfunc(assigns) do
    ~H"""
    <span><%= @test_content %></span>
    """
  end
end
