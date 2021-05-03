defmodule Hangman.Game do

  defstruct(
    game_state: :init,
    turns_left: 7,
    word: [],
  )

  def new_game() do
    %Hangman.Game{}
  end

end
