defmodule TttCore.MixProject do
  use Mix.Project

  def package do
    [
      files: ["lib", "test", "mix.exs", "README.md"],
      maintainers: ["Michael Jacobson"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/michaelbjacobson/ttt_core"}
    ]
  end

  def project do
    [
      app: :ttt_core,
      version: "0.1.0",
      elixir: "~> 1.6",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: "Core logic of a Tic-Tac-Toe game, including an unbeatable minimax-       based computer player.",
      package: package
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end
end
