include("src_patches.jl")
include("base_patches.jl")

const ENV_PATCHES = vcat(
    SRC_PATCHES,
    BASE_PATCHES,
)
