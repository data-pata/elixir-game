defmodule Dict do
  alias Dict.WordList

  @doc """
  returned value is key or pid used to retrieve a random word
  """
  defdelegate start(), to: WordList, as: :start_link

  @doc """
  retrieves a random word
  """
  defdelegate rand_word(), to: WordList

end
