defmodule TextClient do
  @moduledoc """
  TextClient API
  """

  defdelegate start(), to: TextClient.Interaction

end
