module test_envvar_patch

if isdefined(@__MODULE__, :ENV_PATCHES)
    @info :err
    return
end

using Test

env_patches_filepath = normpath(@__DIR__, "../../gen/env_patches.jl")
include(env_patches_filepath)
@test !isempty(ENV_PATCHES)

end # module test_envvar_patch
