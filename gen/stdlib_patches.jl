using EnvironmentVariables
using .EnvironmentVariables: Patch
using PathStrings

# ENV
# get(ENV
# haskey(ENV
# Base.get_bool_env(

const STDLIB_Test_PATCHES = Vector{Patch}([
    # v1.13
    Patch(v"1.13.0-DEV.1075", # julia commit 0b39226110    Add test verbose env var and show when starting/finishing testsets
        Path"stdlib/Test/src/Test.jl",
        EnvKey"JULIA_TEST_VERBOSE" => "const VERBOSE_TESTSETS"
    ),
    Patch(v"1.13.0-DEV.259",  # julia commit d9711317e8    CI: Store Passes in results.json + various improvements
        Path"stdlib/Test/src/Test.jl",
        EnvKey"JULIA_TEST_RECORD_PASSES" => "const TEST_RECORD_PASSES"
    ),

    # v1.9
    Patch(v"1.9.0-DEV.623",   # julia commit 88def1afe1    Test: Add fail-fast mechanism
        Path"stdlib/Test/src/Test.jl",
        EnvKey"JULIA_TEST_FAILFAST" => "const global_fail_fast"
    ),
])

const STDLIB_REPL_PATCHES = Vector{Patch}([
    # v1.11
    Patch(v"1.11.0-DEV.1261", # julia commit 893e720fe8    REPLCompletions: async cache PATH scan
        Path"stdlib/REPL/src/REPLCompletions.jl",
        EnvKey"PATH" => "function cache_PATH()"
    ),

    # v0.7
    Patch(v"0.7.0-DEV.3817",  # julia commit 13b9902b81    move TerminalMenus.jl into a submodule in stdlib/REPL
        Path"stdlib/REPL/src/TerminalMenus/TerminalMenus.jl",
        EnvKey"TERM" => "function default_terminal(; in::IO=stdin, out::IO=stdout, err::IO=stderr)"
    ),
    Patch(v"0.7.0-DEV.3498",  # julia commit 73c989ba51    move REPL to stdlib
        Path"stdlib/REPL/src/REPL.jl",
        EnvKey"JULIA_HISTORY" => "find_hist_file()"
    ),
])

const STDLIB_PATCHES = vcat(
    STDLIB_Test_PATCHES,
    STDLIB_REPL_PATCHES,
)
