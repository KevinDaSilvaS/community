defmodule Repository do

  def fetch(_query \\ "") do
    Mock_DB.get_data() |> Enum.map(fn %_{id: id, url: url, description: description} -> %{
      :id => id,
      :url => url,
      :description => description
    } end)
  end

  def insert(register) do
    Mock_DB.insert_data(register)
  end
end
