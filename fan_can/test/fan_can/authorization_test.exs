defmodule FanCan.AuthorizationTest do
  Use ExUnit.Case
  import FanCan.Accounts.Authorization, except: [can: 1]
  alias FanCan.Public.Candidate

  test "role can read resource" do
    assert can("admin") |> read?(Candidate)
  end
  test "role can create resource" do
    assert can("candidate") |> create?(Candidate)
  end
  test "role can not update resource" do
    assert can("reader") |> update?(Candidate)
  end
  test "role can not delete resource" do
    assert can("voter") |> delete?(Candidate)
  end
end