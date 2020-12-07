defmodule LocaltunnelExClientTest do
  use ExUnit.Case
  doctest LocaltunnelExClient

  test "greets the world" do
    assert LocaltunnelExClient.hello() == :world
  end
end
