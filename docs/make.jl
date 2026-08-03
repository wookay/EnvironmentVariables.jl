using Documenter
using EnvironmentVariables
using .EnvironmentVariables: Patch

makedocs(
    build = joinpath(@__DIR__, "local" in ARGS ? "build_local" : "build"),
    modules = [EnvironmentVariables],
    checkdocs_ignored_modules = [EnvironmentVariables.Docs],
    clean = false,
    format = Documenter.HTML(
        prettyurls = !("local" in ARGS),
        assets = ["assets/custom.css"],
        size_threshold = 1_000_000,
    ),
    sitename = "EnvironmentVariables.jl 🔡",
    authors = "WooKyoung Noh",
    pages = Any[
        "Home" => "index.md",
        "EnvironmentVariables.Docs" => "Docs.md",
        "src/ cli/ ENV variables" => "src_patches.md",
        "base/ ENV variables" => "base_patches.md",
        "STDLIB ENV variables" => "stdlib_patches.md",
    ],
)
