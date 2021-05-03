defmodule Lst do

  def sum lst do sum lst, 0 end
  def sum [], s do s end
  def sum [h | t], s do sum t, s+h end

  def doub lst do doub lst, [] end
  def doub [], new do Enum.reverse(new) end
  def doub [h|t], new do doub(t, [h*2|new] ) end

  def double [] do [] end
  def double [h|t] do [2*h | double(t)] end

end
