using Documenter
using EnvironmentVariables
using .EnvironmentVariables: Patch

makedocs(
    build = joinpath(@__DIR__, "local" in ARGS ? "build_local" : "build"),
    modules = [EnvironmentVariables],
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
        "Src Patches" => "src_patches.md",
        "Base Patches" => "base_patches.md",
        "STDLIB Patches" => "stdlib_patches.md",
    ],
)
