module test_envvar_vars

using Test
using EnvironmentVariables

@test @EnvVar(JULIA_TEST_VERBOSE::Bool) ==
      @EnvVar(JULIA_TEST_VERBOSE::Bool, default := false) ==
      Base.get_bool_env("JULIA_TEST_VERBOSE", false)

@test @EnvVar(LINES::Int, default := 24) ==
      parse(Int, get(ENV, "LINES", "24"))

@test @EnvVar(JULIA_CPU_TARGET::Union{Nothing, String}) ==
      @EnvVar(JULIA_CPU_TARGET::Union{Nothing, String}, default := nothing) ==
      get(ENV, "JULIA_CPU_TARGET", nothing)

@test @EnvVar(JULIA_DEBUG::String) ==
      @EnvVar(JULIA_DEBUG::String, default := "") ==
      get(ENV, "JULIA_DEBUG", "")

end # module test_envvar_vars
