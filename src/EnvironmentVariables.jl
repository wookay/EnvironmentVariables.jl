module EnvironmentVariables

export EnvKeyString, @EnvKey_str, @EnvVar

include("types.jl")
include(normpath(@__DIR__, "../gen/Docs.jl"))
include("Docs_extra.jl")
include("show.jl")

end # module EnvironmentVariables
