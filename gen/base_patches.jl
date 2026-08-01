using EnvironmentVariables
using .EnvironmentVariables: Patch
using PathStrings

# ENV
# get(ENV
# Base.get_bool_env(

const BASE_PATCHES = Vector{Patch}([
    # v1.14
    Patch(v"1.14.0-DEV.2857", # julia commit da4b652b09    errorshow: collapse code loading frames in package stacktraces
        Path"base/errorshow.jl",
        EnvKey"JULIA_STACKTRACE_FULL_LOADING" => "stacktrace_full_loading()::Bool"
    ),
    Patch(v"1.14.0-DEV.2014", # julia commit 9b03f4ae1b    Redact sensitive env vars when printing cmd errors
        Path"base/cmd.jl",
        EnvKey"JULIA_SHOW_ENV" => "function get_show_env_mode(io::IO)"
    ),

    # v1.13
    Patch(v"1.13.0-DEV.1217", # julia commit c4683c41a8    Enable verbose debugging when github actions etc. requests it
        Path"base/client.jl",
        EnvKey"JULIA_TEST_VERBOSE" => "function exec_options(opts)",
        EnvKey"RUNNER_DEBUG" => "function exec_options(opts)",
        EnvKey"CI_DEBUG_TRACE" => "function exec_options(opts)",
        EnvKey"SYSTEM_DEBUG" => "function exec_options(opts)"
    ),

    # v1.12
    Patch(v"1.12.0-DEV.912",  # julia commit 0bb650ccbf    [REPL] improve quality of precompile script
        Path"base/client.jl",
        EnvKey"TERM" => "function run_std_repl(REPL::Module, quiet::Bool, banner::Symbol, history_file::Bool)"
    ),
    Patch(v"1.12.0-DEV.612",  # julia commit 0bf392e671    Enable support for `NO_COLOR` and `FORCE_COLOR` environment variables
        Path"base/options.jl",
        EnvKey"FORCE_COLOR" => "function colored_text(opts::JLOptions)",
        EnvKey"NO_COLOR" => "function colored_text(opts::JLOptions)"
    ),

    # v1.11
    Patch(v"1.11.0-DEV.504",  # julia commit e7290dc1fc    Add environment variable to force the use of the fallback repl
        Path"base/client.jl",
        EnvKey"JULIA_FALLBACK_REPL" => "function run_main_repl(interactive::Bool, quiet::Bool, banner::Symbol, history_file::Bool)"
    ),

    # v1.10
    Patch(v"1.10.0-DEV.1294", # julia commit e4924c51de    add devdocs how to profile package precompilation with tracy
        Path"base/Base.jl",
        EnvKey"JULIA_WAIT_FOR_TRACY" => "function __init__()"
    ),
    Patch(v"1.10.0-DEV.204",  # julia commit a2db90fe8d    Implement support for object caching through pkgimages
        Path"base/loading.jl",
        EnvKey"JULIA_CPU_TARGET" => """function create_expr_cache(pkg::PkgId, input::PkgLoadSpec, output::String, output_o::Union{Nothing, String},
                           concrete_deps::typeof(_concrete_dependencies), flags::Cmd=``, cacheflags::CacheFlags=CacheFlags(),
                           internal_stderr::IO = stderr, internal_stdout::IO = stdout, loadable_exts::Union{Vector{PkgId},Nothing}=nothing;
                           report_timing::Bool=false)""",
        EnvKey"JULIA_CPU_TARGET" => """function compilecache_path(pkg::PkgId, prefs_blob::String; flags::CacheFlags=CacheFlags(), project::String=something(Base.active_project(), ""))::String"""
    ),

    # v1.6
    Patch(v"1.6.0-DEV.1167",  # julia commit 58605d3702    Make it possible to override MAX_NUM_PRECOMPILE_FILES using ENV
        Path"base/Base.jl",
        EnvKey"JULIA_MAX_NUM_PRECOMPILE_FILES" => "function __init__()"
    ),

    # v0.7
    Patch(v"0.7.0-beta.90",   # julia commit 2549e227cf    Pkg + code loading: home project & active project concepts
        Path"base/initdefs.jl",
        EnvKey"JULIA_PROJECT" => "function init_active_project()"
    ),
    Patch(v"0.7.0-DEV.4898",  # julia commit 50413a46a0    change default LOAD_PATH and DEPOT_PATH
        Path"base/loading.jl",
        EnvKey"JULIA_LOAD_PATH" => "function load_path_setup_code(load_path::Bool=true)",
        EnvKey"JULIA_LOAD_PATH" => """function include_package_for_output(pkg::PkgId, input::String, syntax_version::VersionNumber, depot_path::Vector{String}, dl_load_path::Vector{String},
                                                                          load_path::Vector{String}, concrete_deps::typeof(_concrete_dependencies), source::Union{Nothing,String})"""
    ),
    Patch(v"0.7.0-DEV.3483",  # julia commit 865c08e0ce    Pkg3-style code loading, DEPOT_PATH, tests
        Path"base/initdefs.jl",
        EnvKey"JULIA_DEPOT_PATH" => "function init_depot_path()"
    ),

    # v0.4
    Patch(v"0.4.0-dev+1852",  # julia commit e84d85dcac    Fix #9103, implementing `cd -` in REPL shell mode
        Path"base/client.jl",
        EnvKey"OLDPWD" => "function repl_cmd(cmd::AbstractCmd, out)"
    ),
    Patch(v"0.4.0-dev+1734",  # julia commit 571a8c779e    split client.jl into REPL-related pieces and basic initialization definitions
        Path"base/initdefs.jl",
        EnvKey"JULIA_LOAD_PATH" => "function init_load_path()"
    ),

    # v0.2
    Patch(v"0.2.0-rc2+39",    # julia commit 85d81b33e8    `;cmd`: let JULIA_SHELL over-ride the value of SHELL
        Path"base/client.jl",
        EnvKey"JULIA_SHELL" => "function repl_cmd(cmd::AbstractCmd, out)"
    ),
    Patch(v"0.2.0-rc1+173",   # julia commit 37ae1e4abf    run `;cmd` through a shell
        Path"base/client.jl",
        EnvKey"SHELL" => "function repl_cmd(cmd::AbstractCmd, out)"
    ),
])
