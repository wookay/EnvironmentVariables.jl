using EnvironmentVariables
using PathStrings

struct Patch
    version::VersionNumber
    filepath::PathString
    key_pairs::Vector{Pair{EnvKeyString, String}}
    function Patch(version::VersionNumber, filepath::PathString, env_keys::Pair{EnvKeyString, String}...)
        key_pairs::Vector{Pair{EnvKeyString, String}} = collect(env_keys)
        new(version, filepath, key_pairs)
    end
end

const ENV_PATCHES = Vector{Patch}([
    # v1.14
    Patch(v"1.14.0-DEV.2614", # julia commit 6aa38364cb    Add the objcache (LMDB-based cache for LLVM compilation)
        Path"src/objcache.cpp",
        EnvKey"JULIA_OBJCACHE_CAPACITY" => "static const size_t OBJCACHE_CAPACITY",
        EnvKey"JULIA_OBJCACHE" => "void ObjCache::initDB()",
        EnvKey"JULIA_OBJCACHE_LOG" => "static FILE *getLogFile()",
        EnvKey"JULIA_OBJCACHE_PATH" => "static std::optional<std::string> getCachePath() JL_CANSAFEPOINT"
    ),
    Patch(v"1.14.0-DEV.2582", # julia commit a6cf20fa5d    Integrate MMTk binding into Julia build (src/gc-mmtk)
        Path"src/gc-mmtk/gc-mmtk.c",
        EnvKey"MMTK_MIN_HSIZE" => "void jl_gc_init(void)",
        EnvKey"MMTK_MIN_HSIZE_G" => "void jl_gc_init(void)",
        EnvKey"MMTK_MAX_HSIZE" => "void jl_gc_init(void)",
        EnvKey"MMTK_MAX_HSIZE_G" => "void jl_gc_init(void)"
    ),
    Patch(v"1.14.0-DEV.2425", # julia commit e319a303a7    precompilation: coordinate number of workers and imaging threads via a jobserver
        Path"src/aotcompile.cpp",
        EnvKey"JULIA_PRECOMPILE_JOBSERVER" => "struct JobserverClient { bool open() }"
    ),
    Patch(v"1.14.0-DEV.2313", # julia commit acaea7226f    Add dynamic ASAN detection for RTLD_DEEPBIND / `dlopen` workarounds
        Path"src/dlload.c",
        EnvKey"JULIA_ASAN_COMPAT" => "int jl_running_under_sanitizer(int recheck) JL_NOTSAFEPOINT",
        EnvKey"JULIA_USE_RTLD_DEEPBIND" => "static int jl_use_rtld_deepbind(int recheck) JL_NOTSAFEPOINT"
    ),
    Patch(v"1.14.0-DEV.2037", # julia commit d5c76d6dcb    Replace hand-maintained CPU tables with cpufeatures library
        Path"src/processor.cpp",
        EnvKey"JULIA_DEBUG" => "static bool cpufeatures_debug_enabled() JL_NOTSAFEPOINT"
    ),

    # v1.12
    Patch(v"1.12.0-DEV.1578", # julia commit f336314762    Make heap size hint available as an env variable
        Path"src/gc-stock.c",
        EnvKey"JULIA_HEAP_SIZE_HINT" => "void jl_gc_init(void)"
    ),

    # v1.11
    Patch(v"1.11.0-DEV.1076", # julia commit bb2822275b    better support threads in precompile and jl_task_wait_empty
        Path"src/scheduler.c",
        EnvKey"JULIA_THREAD_SLEEP_THRESHOLD" => "void jl_init_threadinginfra(void)"
    ),

    # v1.10
    Patch(v"1.10.0-DEV.1147", # julia commit abeecee71c    Implement parallel marking
        Path"src/threading.c",
        EnvKey"JULIA_NUM_GC_THREADS" => "void jl_init_threading(void)"
    ),
    Patch(v"1.10.0-DEV.964",  # julia commit 8e0cba5663    timing: add envvars for subsystem enable and verbose metadata
        Path"src/jlapi.c",
        EnvKey"JULIA_WAIT_FOR_TRACY" => "JL_DLLEXPORT int jl_repl_entrypoint(int argc, char *argv[]) JL_CANSAFEPOINT_ENTER_LEAVE"
    ),
    Patch(v"1.10.0-DEV.964",  # julia commit 8e0cba5663    timing: add envvars for subsystem enable and verbose metadata
        Path"src/timing.c",
        EnvKey"JULIA_TIMING_SUBSYSTEMS" => "static void jl_timing_set_enable_from_env(void)",
        EnvKey"JULIA_TIMING_METADATA_PRINT_LIMIT" => "static void jl_timing_set_print_limit_from_env(void)"
    ),
    Patch(v"1.10.0-DEV.716",  # julia commit 4e35f416bb    Clean up timers and prints, link to JULIA_IMAGE_TIMINGS
        Path"src/aotcompile.cpp",
        EnvKey"JULIA_IMAGE_TIMINGS" => """
template<typename ModuleReleasedFunc>
static SmallVector<AOTOutputs, 16> add_output(Module &M, TargetMachine &TM, StringRef name, unsigned threads,
                bool unopt_out, bool opt_out, bool obj_out, bool asm_out,
                JobserverClient *jobserver, ModuleReleasedFunc module_released)"""
    ),
    Patch(v"1.10.0-DEV.715",  # julia commit 8cf48f2369    Don't inject CRT aliases on macos
        Path"src/aotcompile.cpp",
        EnvKey"JULIA_CPU_THREADS" => "static unsigned compute_image_thread_count(const ModuleInfo &info, bool jobserver_active)"
    ),
    Patch(v"1.10.0-DEV.703",  # julia commit 3915101dc6    Multithreaded image builder
        Path"src/aotcompile.cpp",
        EnvKey"JULIA_IMAGE_THREADS" => "static unsigned compute_image_thread_count(const ModuleInfo &info, bool jobserver_active)"
    ),

    # v1.8
    Patch(v"1.8.0-DEV.661",   # julia commit 628209c1f2    separate codegen/LLVM from julia runtime
        Path"src/codegen.cpp",
        EnvKey"ENABLE_GDBLISTENER" => """extern "C" void jl_init_llvm(void)"""
    ),

    # v1.3
    Patch(v"1.3.0-alpha.120", # julia commit ae4e08c558    add environment variable `JULIA_ALWAYS_COPY_STACKS`
        Path"src/task.c",
        EnvKey"JULIA_COPY_STACKS" => "void jl_init_tasks(void)"
    ),

    # v0.7
    Patch(v"0.7.0-DEV.2999",  # julia commit 6885af8c94    rename JULIA_HOME/JULIA_HOME => JULIA_BINDIR/Sys.BINDIR
        Path"src/jlapi.c",
        EnvKey"JULIA_BINDIR" => "static void jl_resolve_sysimg_location(JL_IMAGE_SEARCH rel, const char* julia_bindir)"
    ),

    # v0.4
    Patch(v"0.4.0-dev+2635",  # julia commit 5cdc03b31b    Merging threads branch
        Path"src/threading.c",
        EnvKey"JULIA_NUM_THREADS" => "void jl_init_threading(void)",
        EnvKey"JULIA_EXCLUSIVE" => "void jl_start_threads(void)",
    ),
    Patch(v"0.4.0-dev+2494",  # julia commit b60e7306d3    GC debugging tweaks
        Path"src/gc-debug.c",
        EnvKey"JULIA_GC_WAIT_FOR_DEBUGGER" => "void jl_gc_debug_init(void)"
    ),

    # v0.2
    Patch(v"0.2.0-rc1+50",    # julia commit a13bce29ae    Enble LLVM support for Intel VTune Amplifier if platform supports it
        Path"src/codegen.cpp",
        EnvKey"ENABLE_JITPROFILING" => """extern "C" void jl_init_llvm(void)"""
    ),
])
