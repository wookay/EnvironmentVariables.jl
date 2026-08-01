using EnvironmentVariables
using .EnvironmentVariables: Patch
using PathStrings

const BASE_PATCHES = Vector{Patch}([
    # v1.10
    Patch(v"1.10.0-DEV.1294", # julia commit e4924c51de    add devdocs how to profile package precompilation with tracy
        Path"base/Base.jl",
        EnvKey"JULIA_WAIT_FOR_TRACY" => "function __init__()"
    )

    # v1.6
    Patch(v"1.6.0-DEV.1167",  # julia commit 58605d3702    Make it possible to override MAX_NUM_PRECOMPILE_FILES using ENV
        Path"base/Base.jl",
        EnvKey"JULIA_MAX_NUM_PRECOMPILE_FILES" => "function __init__()"
    )
])
