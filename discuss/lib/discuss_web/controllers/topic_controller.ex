defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller

  def new(conn, _params) do
    # json(conn, %{status: "success", message: "I don't know what to tell you"})
    # render(conn, :create_new_topic)
    conn
    |> put_flash(:info, "Welcome to create a new discussion!")
    |> render(:create_new_topic)
  end
end
