defmodule Dicti do

  def wordlist do
    "../assets/words.txt"
    |> Path.expand(__DIR__)
    |> File.read!()
    |> String.split()
  end

  def rand_word do
    wordlist()
    |> Enum.random()
  end

end
