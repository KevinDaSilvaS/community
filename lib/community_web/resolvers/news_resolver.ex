defmodule CommunityWeb.NewsResolver do

  def all_links(_root, _args, _info) do
    {:ok, Mock_DB.get_data()}
  end

  def create_link(_root, args, _info) do
    %_{description: _d, id: id, url: _url} = Mock_DB.get_data() |> List.last()
    desc = Map.fetch! args, :description
    url  = Map.fetch! args, :url

    link = %Link{id: id+1, url: url, description: desc}
    Mock_DB.insert_data(link)
    {:ok, link}
  end
end
