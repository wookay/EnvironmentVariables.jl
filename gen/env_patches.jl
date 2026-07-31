using EnvironmentVariables
using PathStrings

struct Patch
    version::VersionNumber
    envvar::EnvVarString
    filepath::PathString
    signature::String
end

const ENV_PATCHES = Vector{Patch}([
    # v1.14
    Patch(v"1.14.0-DEV.2425", # julia commit e319a303a7    precompilation: coordinate number of workers and imaging threads via a jobserver
        EnvVar"JULIA_PRECOMPILE_JOBSERVER",
        Path"src/aotcompile.cpp",
        "struct JobserverClient { bool open() }",
    ),
    Patch(v"1.14.0-DEV.2313", # julia commit acaea7226f    Add dynamic ASAN detection for RTLD_DEEPBIND / `dlopen` workarounds
        EnvVar"JULIA_ASAN_COMPAT",
        Path"src/dlload.c",
        "int jl_running_under_sanitizer(int recheck) JL_NOTSAFEPOINT",
    ),
    Patch(v"1.14.0-DEV.2313", # julia commit acaea7226f    Add dynamic ASAN detection for RTLD_DEEPBIND / `dlopen` workarounds
        EnvVar"JULIA_USE_RTLD_DEEPBIND",
        Path"src/dlload.c",
        "static int jl_use_rtld_deepbind(int recheck) JL_NOTSAFEPOINT",
    ),

    # v1.10
    Patch(v"1.10.0-DEV.716",  # julia commit 4e35f416bb    Clean up timers and prints, link to JULIA_IMAGE_TIMINGS
        EnvVar"JULIA_IMAGE_TIMINGS",
        Path"src/aotcompile.cpp",
        """template<typename ModuleReleasedFunc>
static SmallVector<AOTOutputs, 16> add_output(Module &M, TargetMachine &TM, StringRef name, unsigned threads,
                bool unopt_out, bool opt_out, bool obj_out, bool asm_out,
                JobserverClient *jobserver, ModuleReleasedFunc module_released)"""
    ),
    Patch(v"1.10.0-DEV.715",  # julia commit 8cf48f2369    Don't inject CRT aliases on macos
        EnvVar"JULIA_CPU_THREADS",
        Path"src/aotcompile.cpp",
        "static unsigned compute_image_thread_count(const ModuleInfo &info, bool jobserver_active)"
    ),
    Patch(v"1.10.0-DEV.703",  # julia commit 3915101dc6    Multithreaded image builder
        EnvVar"JULIA_IMAGE_THREADS",
        Path"src/aotcompile.cpp",
        "static unsigned compute_image_thread_count(const ModuleInfo &info, bool jobserver_active)"
    ),

    # v1.8
    Patch(v"1.8.0-DEV.661",   # julia commit 628209c1f2    separate codegen/LLVM from julia runtime
        EnvVar"ENABLE_GDBLISTENER",
        Path"src/codegen.cpp",
        "extern "C" void jl_init_llvm(void)"
    ),

    # v0.2
    Patch(v"0.2.0-rc1+50",    # julia commit a13bce29ae    Enble LLVM support for Intel VTune Amplifier if platform supports it
        EnvVar"ENABLE_JITPROFILING",
        Path"src/codegen.cpp",
        "extern "C" void jl_init_llvm(void)"
    ),
])
