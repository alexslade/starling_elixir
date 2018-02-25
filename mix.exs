defmodule Starling.Mixfile do
  use Mix.Project

  def project do
    [
      app: :starling,
      version: "0.4.0",
      elixir: "~> 1.4",
      description: "An Elixir wrapper for the Starling Bank API",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      source_url: "https://github.com/heeton/starling_elixir",
      package: package()
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:mix_test_watch, "~> 0.5", only: :dev, runtime: false},
      {:dialyxir, "~> 0.5", only: [:dev], runtime: false},
      {:credo, "~> 0.8", only: [:dev, :test], runtime: false},
      {:exhal, "~> 7.0.1"},
      {:poison, "~> 3.0"},
      {:exconstructor, "~> 1.1.0"},
      {:plug, "~> 1.2"},
      {:exvcr, "~> 0.8.0", only: :test}
    ]
  end

  defp package() do
    [
      name: "starling_elixir",
      files: ["lib", "test", "config", "mix.exs", "README.md", "LICENSE.md"],
      maintainers: ["Alex Heeton"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/heeton/starling_elixir"}
    ]
  end
end
