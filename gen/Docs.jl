# generated 
# docs from julia/doc/src/manual/environment-variables.md
module Docs # EnvironmentVariables

export JULIA_BINDIR, JULIA_PROJECT, JULIA_LOAD_PATH, JULIA_DEPOT_PATH, JULIA_HISTORY, JULIA_MAX_NUM_PRECOMPILE_FILES, JULIA_VERBOSE_LINKING, JULIA_CI, JULIA_NUM_PRECOMPILE_TASKS, JULIA_PRECOMPILE_THREADS, JULIA_PKG_DEVDIR, JULIA_PKG_IGNORE_HASHES, JULIA_PKG_OFFLINE, JULIA_PKG_PRECOMPILE_AUTO, JULIA_PKG_SERVER, JULIA_PKG_SERVER_REGISTRY_PREFERENCE, JULIA_PKG_UNPACK_REGISTRY, JULIA_PKG_USE_CLI_GIT, JULIA_PKGRESOLVE_ACCURACY, JULIA_PKG_PRESERVE_TIERED_INSTALLED, JULIA_PKG_GC_AUTO, JULIA_NO_VERIFY_HOSTS, JULIA_SSL_NO_VERIFY_HOSTS, JULIA_SSH_NO_VERIFY_HOSTS, JULIA_ALWAYS_VERIFY_HOSTS, JULIA_SSL_CA_ROOTS_PATH, JULIA_SHELL, JULIA_EDITOR, JULIA_CPU_THREADS, JULIA_WORKER_TIMEOUT, JULIA_NUM_THREADS, JULIA_THREAD_SLEEP_THRESHOLD, JULIA_NUM_GC_THREADS, JULIA_IMAGE_THREADS, JULIA_IMAGE_TIMINGS, JULIA_EXCLUSIVE, JULIA_HEAP_SIZE_HINT, JULIA_ERROR_COLOR, JULIA_WARN_COLOR, JULIA_INFO_COLOR, JULIA_INPUT_COLOR, JULIA_ANSWER_COLOR, NO_COLOR, FORCE_COLOR, JULIA_CPU_TARGET, JULIA_DEBUG, JULIA_PROFILE_PEEK_HEAP_SNAPSHOT, JULIA_TIMING_SUBSYSTEMS, JULIA_GC_WAIT_FOR_DEBUGGER, ENABLE_JITPROFILING, ENABLE_GDBLISTENER, JULIA_LLVM_ARGS, JULIA_FALLBACK_REPL, JULIA_LOAD_CODEGEN_LIB

using ..EnvironmentVariables: EnvKeyString

"""The absolute path of the directory containing the Julia executable, which sets the global variable [`Sys.BINDIR`](@ref). If `\$JULIA_BINDIR` is not set, then Julia determines the value `Sys.BINDIR` at run-time.
The executable itself is one of
```
\$JULIA_BINDIR/julia
\$JULIA_BINDIR/julia-debug
```
by default.
The global variable `Base.DATAROOTDIR` determines a relative path from `Sys.BINDIR` to the data directory associated with Julia. Then the path
```
\$JULIA_BINDIR/\$DATAROOTDIR/julia/base
```
determines the directory in which Julia initially searches for source files (via `Base.find_source_file()`).
Likewise, the global variable `Base.SYSCONFDIR` determines a relative path to the configuration file directory. Then Julia searches for a `startup.jl` file at
```
\$JULIA_BINDIR/\$SYSCONFDIR/julia/startup.jl
\$JULIA_BINDIR/../etc/julia/startup.jl
```
by default (via `Base.load_julia_startup()`).
For example, a Linux installation with a Julia executable located at `/bin/julia`, a `DATAROOTDIR` of `../share`, and a `SYSCONFDIR` of `../etc` will have [`JULIA_BINDIR`](@ref JULIA_BINDIR) set to `/bin`, a source-file search path of
```
/share/julia/base
```
and a global configuration search path of
```
/etc/julia/startup.jl
```
"""
const JULIA_BINDIR = EnvKeyString("JULIA_BINDIR")

"""A directory path that indicates which project should be the initial active project. Setting this environment variable has the same effect as specifying the `--project` start-up option, but `--project` has higher precedence. If the variable is set to `@.` (note the trailing dot) then Julia tries to find a project directory that contains `Project.toml` or `JuliaProject.toml` file from the current directory and its parents. See also the chapter on [Code Loading](@ref code-loading).
!!! note
    [`JULIA_PROJECT`](@ref JULIA_PROJECT) must be defined before starting julia; defining it in `startup.jl` is too late in the startup process.

"""
const JULIA_PROJECT = EnvKeyString("JULIA_PROJECT")

"""The [`JULIA_LOAD_PATH`](@ref JULIA_LOAD_PATH) environment variable is used to populate the global Julia [`LOAD_PATH`](@ref) variable, which determines which packages can be loaded via `import` and `using` (see [Code Loading](@ref code-loading)).
Unlike the shell `PATH` variable, empty entries in [`JULIA_LOAD_PATH`](@ref JULIA_LOAD_PATH) are expanded to the default value of `LOAD_PATH`, `["@", "@v#.#", "@stdlib"]` when populating `LOAD_PATH`. This allows easy appending, prepending, etc. of the load path value in shell scripts regardless of whether [`JULIA_LOAD_PATH`](@ref JULIA_LOAD_PATH) is already set or not. For example, to prepend the directory `/foo/bar` to `LOAD_PATH` just do
```sh
export JULIA_LOAD_PATH="/foo/bar:\$JULIA_LOAD_PATH"
```
If the [`JULIA_LOAD_PATH`](@ref JULIA_LOAD_PATH) environment variable is already set, its old value will be prepended with `/foo/bar`. On the other hand, if [`JULIA_LOAD_PATH`](@ref JULIA_LOAD_PATH) is not set, then it will be set to `/foo/bar:` which will expand to a `LOAD_PATH` value of `["/foo/bar", "@", "@v#.#", "@stdlib"]`. If [`JULIA_LOAD_PATH`](@ref JULIA_LOAD_PATH) is set to the empty string, it expands to an empty `LOAD_PATH` array. In other words, the empty string is interpreted as a zero-element array, not a one-element array of the empty string. This behavior was chosen so that it would be possible to set an empty load path via the environment variable. If you want the default load path, either unset the environment variable or if it must have a value, set it to the string `:`.
!!! note
    On Windows, path elements are separated by the `;` character, as is the case with most path lists on Windows. Replace `:` with `;` in the above paragraph.

"""
const JULIA_LOAD_PATH = EnvKeyString("JULIA_LOAD_PATH")

"""The [`JULIA_DEPOT_PATH`](@ref JULIA_DEPOT_PATH) environment variable is used to populate the global Julia [`DEPOT_PATH`](@ref) variable, which controls where the package manager, as well as Julia's code loading mechanisms, look for package registries, installed packages, named environments, repo clones, cached compiled package images, configuration files, and the default location of the REPL's history file.
Unlike the shell `PATH` variable but similar to [`JULIA_LOAD_PATH`](@ref JULIA_LOAD_PATH), empty entries in [`JULIA_DEPOT_PATH`](@ref JULIA_DEPOT_PATH) have special behavior:
  * At the end, it is expanded to the default value of `DEPOT_PATH`, *excluding* the user depot.
  * At the start, it is expanded to the default value of `DEPOT_PATH`, *including* the user depot.
This allows easy overriding of the user depot, while still retaining access to resources that are bundled with Julia, like cache files, artifacts, etc. For example, to switch the user depot to `/foo/bar` use a trailing `:`
```sh
export JULIA_DEPOT_PATH="/foo/bar:"
```
All package operations, like cloning registries or installing packages, will now write to `/foo/bar`, but since the empty entry is expanded to the default system depot, any bundled resources will still be available. If you really only want to use the depot at `/foo/bar`, and not load any bundled resources, simply set the environment variable to `/foo/bar` without the trailing colon.
To append a depot at the end of the full default list, including the default user depot, use a leading `:`
```sh
export JULIA_DEPOT_PATH=":/foo/bar"
```
There are two exceptions to the above rule. First, if [`JULIA_DEPOT_PATH`](@ref JULIA_DEPOT_PATH) is set to the empty string, it expands to an empty `DEPOT_PATH` array. In other words, the empty string is interpreted as a zero-element array, not a one-element array of the empty string. This behavior was chosen so that it would be possible to set an empty depot path via the environment variable.
Second, if no user depot is specified in [`JULIA_DEPOT_PATH`](@ref JULIA_DEPOT_PATH), then the empty entry is expanded to the default depot *including* the user depot. This makes it possible to use the default depot, as if the environment variable was unset, by setting it to the string `:`.
!!! note
    On Windows, path elements are separated by the `;` character, as is the case with most path lists on Windows. Replace `:` with `;` in the above paragraph.

!!! note
    [`JULIA_DEPOT_PATH`](@ref JULIA_DEPOT_PATH) must be defined before starting julia; defining it in `startup.jl` is too late in the startup process; at that point you can instead directly modify the `DEPOT_PATH` array, which is populated from the environment variable.

"""
const JULIA_DEPOT_PATH = EnvKeyString("JULIA_DEPOT_PATH")

"""The absolute path `REPL.find_hist_file()` of the REPL's history file. If `\$JULIA_HISTORY` is not set, then `REPL.find_hist_file()` defaults to
```
\$(DEPOT_PATH[1])/logs/repl_history.jl
```
"""
const JULIA_HISTORY = EnvKeyString("JULIA_HISTORY")

"""Sets the maximum number of different instances of a single package that are to be stored in the precompile cache (default = 10).
"""
const JULIA_MAX_NUM_PRECOMPILE_FILES = EnvKeyString("JULIA_MAX_NUM_PRECOMPILE_FILES")

"""If set to true, linker commands will be displayed during precompilation.
## Pkg.jl
"""
const JULIA_VERBOSE_LINKING = EnvKeyString("JULIA_VERBOSE_LINKING")

"""If set to `true`, this indicates to the package server that any package operations are part of a continuous integration (CI) system for the purposes of gathering package usage statistics.
"""
const JULIA_CI = EnvKeyString("JULIA_CI")

"""The number of parallel tasks (worker subprocesses) to use when precompiling packages. See [`Pkg.precompile`](https://pkgdocs.julialang.org/v1/api/#Pkg.precompile).
"""
const JULIA_NUM_PRECOMPILE_TASKS = EnvKeyString("JULIA_NUM_PRECOMPILE_TASKS")

"""An unsigned integer that sets the total CPU-thread budget shared across all parallel precompile worker subprocesses, keeping the combined number of active threads bounded no matter how many workers run. Defaults to one more than the number of effective CPU threads.
Unlike [`JULIA_NUM_PRECOMPILE_TASKS`](@ref JULIA_NUM_PRECOMPILE_TASKS) (which caps worker *processes*) and [`JULIA_IMAGE_THREADS`](@ref JULIA_IMAGE_THREADS) (which caps a *per-worker* thread count), this is the shared total. The two compose: the budget bounds what all workers may use together, while `JULIA_IMAGE_THREADS` bounds what any one worker may use. Setting `JULIA_IMAGE_THREADS` alone uses a fixed number of threads in each worker and leaves total threads unconstrained. For example:
  * neither set: budget = `EFFECTIVE_CPU_THREADS + 1`
  * `JULIA_PRECOMPILE_THREADS=8`: 8 total threads
  * `JULIA_IMAGE_THREADS=4`: every worker is pinned to 4 threads; no total thread limit
  * `JULIA_IMAGE_THREADS=4` and `JULIA_PRECOMPILE_THREADS=8`: budget = 8 total threads, with no worker exceeding 4 imaging threads of its own
"""
const JULIA_PRECOMPILE_THREADS = EnvKeyString("JULIA_PRECOMPILE_THREADS")

"""The default directory used by [`Pkg.develop`](https://pkgdocs.julialang.org/v1/api/#Pkg.develop) for downloading packages.
"""
const JULIA_PKG_DEVDIR = EnvKeyString("JULIA_PKG_DEVDIR")

"""If set to `1`, this will ignore incorrect hashes in artifacts. This should be used carefully, as it disables verification of downloads, but can resolve issues when moving files across different types of file systems. See [Pkg.jl issue #2317](https://github.com/JuliaLang/Pkg.jl/issues/2317) for more details.
!!! compat "Julia 1.6"
    This is only supported in Julia 1.6 and above.

"""
const JULIA_PKG_IGNORE_HASHES = EnvKeyString("JULIA_PKG_IGNORE_HASHES")

"""If set to `true`, this will enable offline mode: see [`Pkg.offline`](https://pkgdocs.julialang.org/v1/api/#Pkg.offline).
!!! compat "Julia 1.5"
    Pkg's offline mode requires Julia 1.5 or later.

"""
const JULIA_PKG_OFFLINE = EnvKeyString("JULIA_PKG_OFFLINE")

"""If set to `0`, this will disable automatic precompilation by package actions which change the manifest. See [`Pkg.precompile`](https://pkgdocs.julialang.org/v1/api/#Pkg.precompile).
"""
const JULIA_PKG_PRECOMPILE_AUTO = EnvKeyString("JULIA_PKG_PRECOMPILE_AUTO")

"""Specifies the URL of the package registry to use. By default, `Pkg` uses `https://pkg.julialang.org` to fetch Julia packages. In addition, you can disable the use of the PkgServer protocol, and instead access the packages directly from their hosts (GitHub, GitLab, etc.) by setting: `export JULIA_PKG_SERVER=""`
"""
const JULIA_PKG_SERVER = EnvKeyString("JULIA_PKG_SERVER")

"""Specifies the preferred registry flavor. Currently supported values are `conservative` (the default), which will only publish resources that have been processed by the storage server (and thereby have a higher probability of being available from the PkgServers), whereas `eager` will publish registries whose resources have not necessarily been processed by the storage servers. Users behind restrictive firewalls that do not allow downloading from arbitrary servers should not use the `eager` flavor.
!!! compat "Julia 1.7"
    This only affects Julia 1.7 and above.

"""
const JULIA_PKG_SERVER_REGISTRY_PREFERENCE = EnvKeyString("JULIA_PKG_SERVER_REGISTRY_PREFERENCE")

"""If set to `true`, this will unpack the registry instead of storing it as a compressed tarball.
!!! compat "Julia 1.7"
    This only affects Julia 1.7 and above. Earlier versions will always unpack the registry.

"""
const JULIA_PKG_UNPACK_REGISTRY = EnvKeyString("JULIA_PKG_UNPACK_REGISTRY")

"""If set to `true`, Pkg operations which use the git protocol will use an external `git` executable instead of the default libgit2 library.
!!! compat "Julia 1.7"
    Use of the `git` executable is only supported on Julia 1.7 and above.

"""
const JULIA_PKG_USE_CLI_GIT = EnvKeyString("JULIA_PKG_USE_CLI_GIT")

"""The accuracy of the package resolver. This should be a positive integer, the default is `1`.
"""
const JULIA_PKGRESOLVE_ACCURACY = EnvKeyString("JULIA_PKGRESOLVE_ACCURACY")

"""Change the default package installation strategy to `Pkg.PRESERVE_TIERED_INSTALLED` to let the package manager try to install versions of packages while keeping as many versions of packages already installed as possible.
!!! compat "Julia 1.9"
    This only affects Julia 1.9 and above.

"""
const JULIA_PKG_PRESERVE_TIERED_INSTALLED = EnvKeyString("JULIA_PKG_PRESERVE_TIERED_INSTALLED")

"""If set to `false`, automatic garbage collection of packages and artifacts will be disabled; see [`Pkg.gc`](https://pkgdocs.julialang.org/v1/api/#Pkg.gc) for more details.
!!! compat "Julia 1.12"
    This environment variable is only supported on Julia 1.12 and above.

## Network transport
"""
const JULIA_PKG_GC_AUTO = EnvKeyString("JULIA_PKG_GC_AUTO")

""""""
const JULIA_NO_VERIFY_HOSTS = EnvKeyString("JULIA_NO_VERIFY_HOSTS")

""""""
const JULIA_SSL_NO_VERIFY_HOSTS = EnvKeyString("JULIA_SSL_NO_VERIFY_HOSTS")

""""""
const JULIA_SSH_NO_VERIFY_HOSTS = EnvKeyString("JULIA_SSH_NO_VERIFY_HOSTS")

"""Specify hosts whose identity should or should not be verified for specific transport layers. See [`NetworkOptions.verify_host`](https://github.com/JuliaLang/NetworkOptions.jl#verify_host)
"""
const JULIA_ALWAYS_VERIFY_HOSTS = EnvKeyString("JULIA_ALWAYS_VERIFY_HOSTS")

"""Specify the file or directory containing the certificate authority roots. See [`NetworkOptions.ca_roots`](https://github.com/JuliaLang/NetworkOptions.jl#ca_roots)
## External applications
"""
const JULIA_SSL_CA_ROOTS_PATH = EnvKeyString("JULIA_SSL_CA_ROOTS_PATH")

"""The absolute path of the shell with which Julia should execute external commands (via `Base.repl_cmd()`). Defaults to the environment variable `\$SHELL`, and falls back to `/bin/sh` if `\$SHELL` is unset.
!!! note
    On Windows, this environment variable is ignored, and external commands are executed directly.

"""
const JULIA_SHELL = EnvKeyString("JULIA_SHELL")

"""The editor returned by `InteractiveUtils.editor()` and used in, e.g., [`InteractiveUtils.edit`](@ref), referring to the command of the preferred editor, for instance `vim`.
`\$JULIA_EDITOR` takes precedence over `\$VISUAL`, which in turn takes precedence over `\$EDITOR`. If none of these environment variables is set, then the editor is taken to be `open` on Windows and OS X, or `/etc/alternatives/editor` if it exists, or `emacs` otherwise.
To use Visual Studio Code on Windows, set `\$JULIA_EDITOR` to `code.cmd`.
## Parallelization
"""
const JULIA_EDITOR = EnvKeyString("JULIA_EDITOR")

"""Overrides the global variable [`Base.Sys.CPU_THREADS`](@ref), the number of logical CPU cores available.
"""
const JULIA_CPU_THREADS = EnvKeyString("JULIA_CPU_THREADS")

"""A [`Float64`](@ref) that sets the value of `Distributed.worker_timeout()` (default: `60.0`). This function gives the number of seconds a worker process will wait for a master process to establish a connection before dying.
"""
const JULIA_WORKER_TIMEOUT = EnvKeyString("JULIA_WORKER_TIMEOUT")

"""An unsigned 64-bit integer (`uint64_t`) or string that sets the maximum number of threads available to Julia. If `\$JULIA_NUM_THREADS` is not set or is a non-positive integer, or if the number of CPU threads cannot be determined through system calls, then the number of threads is set to `1`.
If `\$JULIA_NUM_THREADS` is set to `auto`, then the number of threads will be set to the number of CPU threads. It can also be set to a comma-separated string to specify the size of the `:default` and `:interactive` [threadpools](@ref man-threadpools), respectively:
```bash
# 5 threads in the :default pool and 2 in the :interactive pool
export JULIA_NUM_THREADS=5,2

# `auto` threads in the :default pool and 1 in the :interactive pool
export JULIA_NUM_THREADS=auto,1
```
!!! note
    `JULIA_NUM_THREADS` must be defined before starting Julia; defining it in `startup.jl` is too late in the startup process.

!!! compat "Julia 1.5"
    In Julia 1.5 and above the number of threads can also be specified on startup using the `-t`/`--threads` command line argument.

!!! compat "Julia 1.7"
    The `auto` value for `\$JULIA_NUM_THREADS` requires Julia 1.7 or above.

!!! compat "Julia 1.9"
    The `x,y` format for threadpools requires Julia 1.9 or above.

"""
const JULIA_NUM_THREADS = EnvKeyString("JULIA_NUM_THREADS")

"""If set to a string that starts with the case-insensitive substring `"infinite"`, then spinning threads never sleep. Otherwise, `\$JULIA_THREAD_SLEEP_THRESHOLD` is interpreted as an unsigned 64-bit integer (`uint64_t`) and gives, in nanoseconds, the amount of time after which spinning threads should sleep.
"""
const JULIA_THREAD_SLEEP_THRESHOLD = EnvKeyString("JULIA_THREAD_SLEEP_THRESHOLD")

"""Sets the number of threads used by Garbage Collection. If unspecified is set to the number of worker threads.
!!! compat "Julia 1.10"
    The environment variable was added in 1.10

"""
const JULIA_NUM_GC_THREADS = EnvKeyString("JULIA_NUM_GC_THREADS")

"""An unsigned 32-bit integer that sets the number of threads used by image compilation in this Julia process. The value of this variable may be ignored if the module is a small module. If left unspecified, the smaller of the value of [`JULIA_CPU_THREADS`](@ref JULIA_CPU_THREADS) or half the number of logical CPU cores is used in its place.
During parallel package precompilation, workers additionally coordinate their CPU usage through a shared token pool sized by [`JULIA_PRECOMPILE_THREADS`](@ref JULIA_PRECOMPILE_THREADS), so their combined thread count stays bounded. If set, `JULIA_IMAGE_THREADS` limits the imaging threads for a single worker and does not affect the total thread limit.
"""
const JULIA_IMAGE_THREADS = EnvKeyString("JULIA_IMAGE_THREADS")

"""A boolean value that determines if detailed timing information is printed during image compilation. Defaults to 0.
"""
const JULIA_IMAGE_TIMINGS = EnvKeyString("JULIA_IMAGE_TIMINGS")

"""If set to anything besides `0`, then Julia's thread policy is consistent with running on a dedicated machine: each thread in the default threadpool is affinitized.  [Interactive threads](@ref man-threadpools) remain under the control of the operating system scheduler.
Otherwise, Julia lets the operating system handle thread policy.
## Garbage Collection
"""
const JULIA_EXCLUSIVE = EnvKeyString("JULIA_EXCLUSIVE")

"""Environment variable equivalent to the `--heap-size-hint=<size>[<unit>]` command line option.
Forces garbage collection if memory usage is higher than the given value. The value may be specified as a number of bytes, optionally in units of:
```
- B  (bytes)
- K  (kibibytes)
- M  (mebibytes)
- G  (gibibytes)
- T  (tebibytes)
- %  (percentage of physical memory)
```
For example, `JULIA_HEAP_SIZE_HINT=1G` would provide a 1 GB heap size hint to the garbage collector.
## REPL formatting
Environment variables that determine how REPL output should be formatted at the terminal. The `JULIA_*_COLOR` variables should be set to [ANSI terminal escape sequences](https://en.wikipedia.org/wiki/ANSI_escape_code). Julia provides a high-level interface with much of the same functionality; see the section on [The Julia REPL](@ref).
"""
const JULIA_HEAP_SIZE_HINT = EnvKeyString("JULIA_HEAP_SIZE_HINT")

"""The formatting `Base.error_color()` (default: light red, `"\033[91m"`) that errors should have at the terminal.
"""
const JULIA_ERROR_COLOR = EnvKeyString("JULIA_ERROR_COLOR")

"""The formatting `Base.warn_color()` (default: yellow, `"\033[93m"`) that warnings should have at the terminal.
"""
const JULIA_WARN_COLOR = EnvKeyString("JULIA_WARN_COLOR")

"""The formatting `Base.info_color()` (default: cyan, `"\033[36m"`) that info should have at the terminal.
"""
const JULIA_INFO_COLOR = EnvKeyString("JULIA_INFO_COLOR")

"""The formatting `Base.input_color()` (default: normal, `"\033[0m"`) that input should have at the terminal.
"""
const JULIA_INPUT_COLOR = EnvKeyString("JULIA_INPUT_COLOR")

"""The formatting `Base.answer_color()` (default: normal, `"\033[0m"`) that output should have at the terminal.
"""
const JULIA_ANSWER_COLOR = EnvKeyString("JULIA_ANSWER_COLOR")

"""When this variable is present and not an empty string (regardless of its value) then colored text will be disabled on the REPL. Can be overridden with the flag `--color=yes` or with the environment variable [`FORCE_COLOR`](@ref FORCE_COLOR). This environment variable is [commonly recognized by command-line applications](https://no-color.org/).
"""
const NO_COLOR = EnvKeyString("NO_COLOR")

"""When this variable is present and not an empty string (regardless of its value) then colored text will be enabled on the REPL. Can be overridden with the flag `--color=no`. This environment variable is [commonly recognized by command-line applications](https://force-color.org/).
## System and Package Image Building
"""
const FORCE_COLOR = EnvKeyString("FORCE_COLOR")

"""Modify the target machine architecture for (pre)compiling [system](@ref sysimg-multi-versioning) and [package images](@ref pkgimgs-multi-versioning). `JULIA_CPU_TARGET` only affects machine code image generation being output to a disk cache. Unlike the `--cpu-target`, or `-C`, [command line option](@ref cli), it does not influence just-in-time (JIT) code generation within a Julia session where machine code is only stored in memory.
Valid values for [`JULIA_CPU_TARGET`](@ref JULIA_CPU_TARGET) can be obtained by executing `julia -C help`.
To get the CPU target string that was used to build the current system image, use [`Sys.sysimage_target()`](@ref). This can be useful for reproducing the same system image or understanding what CPU features were enabled during compilation.
Setting [`JULIA_CPU_TARGET`](@ref JULIA_CPU_TARGET) is important for heterogeneous compute systems where processors of distinct types or features may be present. This is commonly encountered in high performance computing (HPC) clusters since the component nodes may be using distinct processors. In this case, you may want to use the `sysimage` CPU target to maintain the same configuration as the sysimage. See below for more details.
The CPU target string is a list of strings separated by `;` each string starts with a CPU or architecture name and followed by an optional list of features separated by `,`. A `generic` or empty CPU name means the basic required feature set of the target ISA which is at least the architecture the C/C++ runtime is compiled with. Each string is interpreted by LLVM.
!!! note
    Package images can only target the same or more specific CPU features than their base system image.

A few special features are supported:
1. `sysimage`

    A special keyword that can be used as a CPU target name, which will be replaced   with the CPU target string that was used to build the current system image. This allows   you to specify CPU targets that build upon or extend the current sysimage's target, which   is particularly helpful for creating package images that are as flexible as the sysimage.
2. `clone_all`

    This forces the target to have all functions in sysimg cloned.   When used in negative form (i.e. `-clone_all`), this disables full clone that's   enabled by default for certain targets.
3. `base([0-9]*)`

    This specifies the (0-based) base target index. The base target is the target   that the current target is based on, i.e. the functions that are not being cloned   will use the version in the base target. This option causes the base target to be   fully cloned (as if `clone_all` is specified for it) if it is not the default target (0).   The index can only be smaller than the current index.
4. `opt_size`

    Optimize for size with minimum performance impact. Clang/GCC's `-Os`.
5. `min_size`

    Optimize only for size. Clang's `-Oz`.
## Debugging and profiling
"""
const JULIA_CPU_TARGET = EnvKeyString("JULIA_CPU_TARGET")

"""Enable debug logging for a file or module, see [`Logging`](@ref man-logging) for more information.
"""
const JULIA_DEBUG = EnvKeyString("JULIA_DEBUG")

"""Enable collecting of a heap snapshot during execution via the profiling peek mechanism. See [Triggered During Execution](@ref).
"""
const JULIA_PROFILE_PEEK_HEAP_SNAPSHOT = EnvKeyString("JULIA_PROFILE_PEEK_HEAP_SNAPSHOT")

"""Allows you to enable or disable zones for a specific Julia run. For instance, setting the variable to `+GC,-INFERENCE` will enable the `GC` zones and disable the `INFERENCE` zones. See [Dynamically Enabling and Disabling Zones](@ref).
"""
const JULIA_TIMING_SUBSYSTEMS = EnvKeyString("JULIA_TIMING_SUBSYSTEMS")

"""If set to anything besides `0`, then the Julia garbage collector will wait for a debugger to attach instead of aborting whenever there's a critical error.
!!! note
    This environment variable only has an effect if Julia was compiled with garbage-collection debugging (that is, if `WITH_GC_DEBUG_ENV` is set to `1` in the build configuration).

"""
const JULIA_GC_WAIT_FOR_DEBUGGER = EnvKeyString("JULIA_GC_WAIT_FOR_DEBUGGER")

"""If set to anything besides `0`, then the compiler will create and register an event listener for just-in-time (JIT) profiling.
!!! note
    This environment variable only has an effect if Julia was compiled with JIT profiling support, using either

      * Intel's [VTune™ Amplifier](https://software.intel.com/en-us/vtune) (`USE_INTEL_JITEVENTS` set to `1` in the build configuration), or
      * [OProfile](https://oprofile.sourceforge.io/news/) (`USE_OPROFILE_JITEVENTS` set to `1` in the build configuration).
      * [Perf](https://perf.wiki.kernel.org) (`USE_PERF_JITEVENTS` set to `1` in the build configuration). This integration is enabled by default.

"""
const ENABLE_JITPROFILING = EnvKeyString("ENABLE_JITPROFILING")

"""If set to anything besides `0` enables GDB registration of Julia code on release builds. On debug builds of Julia this is always enabled. Recommended to use with `-g 2`.
"""
const ENABLE_GDBLISTENER = EnvKeyString("ENABLE_GDBLISTENER")

"""Arguments to be passed to the LLVM backend.
"""
const JULIA_LLVM_ARGS = EnvKeyString("JULIA_LLVM_ARGS")

"""Forces the fallback repl instead of REPL.jl.
"""
const JULIA_FALLBACK_REPL = EnvKeyString("JULIA_FALLBACK_REPL")

"""If set to a false value (`0`, `f`, `false`, `n`, or `no`, case-insensitive), the loader does not load `libjulia-codegen`, and the fallback (interpreter-only) implementations in `libjulia-internal` are used instead — exactly as if the library were absent from the installation. Intended for testing and debugging the no-codegen configuration.
"""
const JULIA_LOAD_CODEGEN_LIB = EnvKeyString("JULIA_LOAD_CODEGEN_LIB")

end # module EnvironmentVariables.Docs
