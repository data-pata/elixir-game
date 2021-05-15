defmodule Tracer do
  use GenServer

  def start(modules), do: GenServer.start(__MODULE__, modules)

  def init(modules) do
    :erlang.trace(:all, true, [:call])

    for module <- modules do
      :erlang.trace_pattern({module, :_, :_}, [{:_, [], [{:return_trace}]}])
    end

    {:ok, nil}
  end

  def handle_info({:trace, _, :call, {mod, fun, args}}, state) do
    IO.puts "called #{mod}.#{fun}(#{Enum.join(Enum.map(args, &inspect/1), ",")})"
    {:noreply, state}
  end

  def handle_info({:trace, _, :return_from, {mod, fun, arity}, res}, state) do
    IO.puts "#{mod}.#{fun}/#{arity} returned #{res}"
    {:noreply, state}
  end

  def handle_info(_, state), do: {:noreply, state}
end
