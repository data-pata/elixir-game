defmodule TextClient.State do

  defstruct [
    game_service: nil,
    tally: nil,
    guessed_letter: ""
  ]
end
