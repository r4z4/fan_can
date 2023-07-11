defmodule FanCan.PropertyTest do
  use ExUnit.Case
  use PropCheck

  property "all generated number must be greated than zero", [:verbose] do
    forall number <- non_neg_integer() do
      assert number >= 0
    end
  end

end