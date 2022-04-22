defmodule CommunityWeb.NewsResolver do

  def all_links(_root, _args, _info) do
    {:ok, Mock_DB.get_data()}
  end

  def create_link(_root, %{:description => desc, :url => url}, _info) do
    %_{description: _d, id: id, url: _url} = Mock_DB.get_data() |> List.last()

    link = %Link{id: id+1, url: url, description: desc}
    Mock_DB.insert_data(link)
    {:ok, link}
  end

  def get_link(_root, %{:id => id}, _info) do
    results = Mock_DB.get_data()
        |> Enum.filter(fn %_{id: link_id, url: _, description: _} -> link_id==String.to_integer(id) end)
    {:ok, results}
  end

  def update_link(_root, args, _info) do
    id = Map.fetch!(args, :id) |> String.to_integer()
    {:ok, result} = get_link(nil, %{:id => "#{id}"}, nil)

    case result do
      [] -> {:error, :not_found}
      [result | _]  ->
        url         = args[:url] || Map.fetch!(result, :url)
        description = args[:description] || Map.fetch!(result, :description)

        data = Mock_DB.get_data()
              |> Enum.reject(fn %_{id: link_id, url: _, description: _} -> link_id==id end)

        register = %Link{id: id, url: url, description: description}

        registers = data ++ [register]
        Mock_DB.update_data registers
        {:ok, register}
    end
  end
end
