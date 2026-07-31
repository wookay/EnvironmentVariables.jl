module test_envvar_types

using Test
using EnvironmentVariables
using .EnvironmentVariables: EnvVarEmptyNameError

@test_throws EnvVarEmptyNameError EnvVar""
@test EnvVar"JULIA_PRECOMPILE_JOBSERVER" isa EnvVarString

end # module test_envvar_types
