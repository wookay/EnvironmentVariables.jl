module test_envvar_vars

using Test
using EnvironmentVariables

@test @EnvVar(JULIA_TEST_VERBOSE::Bool, default := false) == Base.get_bool_env("JULIA_TEST_VERBOSE", false)
@test @EnvVar(LINES::Int, default := 24) == parse(Int, get(ENV, "LINES", "24"))

end # module test_envvar_vars
