defmodule CommunityWeb.GetDataController do
  use CommunityWeb, :controller

  def get_data(conn, _opts) do
    conn |> put_status(200) |> json(Repository.fetch())
  end
end
