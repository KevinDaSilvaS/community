defmodule Mock_DB do
  use Agent

  def start_link(_) do
    Agent.start_link(fn -> [
      %Link{id: 1, url: "http://graphql.org/",        description: "The Best Query Language"},
      %Link{id: 2, url: "http://dev.apollodata.com/", description: "Awesome GraphQL Client"}
    ] end, name: __MODULE__)
  end

  def get_data do
    Agent.get(__MODULE__, & &1)
  end

  def insert_data(register) do
    Agent.update(__MODULE__, &(&1 ++ [register]))
  end

  def update_data(registers) do
    Agent.update(__MODULE__, fn _ -> registers end)
  end
end
