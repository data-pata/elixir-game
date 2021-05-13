defmodule Dict.WordList do

  @name __MODULE__

  def start_link() do
    Agent.start_link(&read_word_list/0, name: @name )
  end

  # defp agent_pid({:ok, pid}), do: pid
  # defp agent_pid({_, reason}) do
  #   IO.puts "failed starting server #{reason}"
  #   exit(reason)
  # end

  def read_word_list() do
    "../../assets/words.txt"
    |> Path.expand(__DIR__)
    |> File.read!()
    |> String.split()
  end

  def rand_word() do
    # if :rand.uniform < 0.33 do
    #   Agent.get(@name, fn _ -> exit(:boom) end )
    # end
    Agent.get(@name, fn wl -> Enum.random(wl) end)
    # |> Enum.random()
  end

end
