defmodule Dict.App do
  use Application

  def start(_type, _args) do
    Dict.WordList.start_link()
  end

end
