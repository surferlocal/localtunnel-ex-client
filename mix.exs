defmodule LocaltunnelExClient.MixProject do
  use Mix.Project

  def project do
    [
      app: :localtunnel_ex_client,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {LocaltunnelExClient.Application, []},
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:exexec, "~> 0.2"}
    ]
  end
end
