defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller

  def new(conn, _params) do
    render(conn, :create_new_topic)
  end
end
