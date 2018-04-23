defmodule GeorgeCompiler.MixProject do
  use Mix.Project

  def project do
    [
      app: :george_compiler,
      version: "0.1.0",
      elixir: "~> 1.6",
      escript: [main_module: GeorgeCompiler.CLI],
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:neotomex, "~> 0.1.7"},
      {:dbg, "~> 1.0"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
    ]
  end
end
