using EnvironmentVariables
using PathStrings

struct Patch
    version::VersionNumber
    envvar::EnvVarString
    path::PathString
    signature::String
end

const ENV_PATCHES = Vector{Patch}([
    # v1.14
    Patch(v"1.14.0-DEV.2425", # julia commit e319a303a7    precompilation: coordinate number of workers and imaging threads via a jobserver
         EnvVar"JULIA_PRECOMPILE_JOBSERVER",
         Path"src/aotcompile.cpp",
         "struct JobserverClient { bool open() }",
    ),

    # v1.10
    Patch(v"1.10.0-DEV.716",  # julia commit 4e35f416bb    Clean up timers and prints, link to JULIA_IMAGE_TIMINGS
         EnvVar"JULIA_IMAGE_TIMINGS",
         Path"src/aotcompile.cpp",
         """template<typename ModuleReleasedFunc>
static SmallVector<AOTOutputs, 16> add_output(Module &M, TargetMachine &TM, StringRef name, unsigned threads,
                bool unopt_out, bool opt_out, bool obj_out, bool asm_out,
                JobserverClient *jobserver, ModuleReleasedFunc module_released)"""
    )
])
