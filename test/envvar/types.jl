module test_envvar_types

using Test
using EnvironmentVariables
using .EnvironmentVariables: EnvKeyEmptyNameError

@test_throws EnvKeyEmptyNameError EnvKey""
@test EnvKey"JULIA_PRECOMPILE_JOBSERVER" isa EnvKeyString

end # module test_envvar_types
