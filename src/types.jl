# module EnvironmentVariables

using PathStrings

struct EnvKeyEmptyNameError <: Exception
end

struct EnvKeyString
    s::String
end

function valid_envkeystring(s)
    if isempty(s)
        throw(EnvKeyEmptyNameError())
    else
        EnvKeyString(s)
    end
end

macro EnvKey_str(s)
    quote
        valid_envkeystring($s)
    end
end

macro EnvVar(a::Expr, b::Expr)
    default = nothing
    if b.head === :(:=)
        name, val = (b.args)
        if name === :default
            default = val
        end
    end
    if a.head === :(::)
        k, T = (a.args)
        key = String(k)
        if T === :Bool
            :(Base.get_bool_env($key, $default))
        elseif T === :Int
            :(Base.parse(Int, get(ENV, $key, string($default))))
        end
    end
end

struct Patch
    version::VersionNumber
    filepath::PathString
    key_pairs::Vector{Pair{EnvKeyString, String}}
    function Patch(version::VersionNumber, filepath::PathString, env_keys::Pair{EnvKeyString, String}...)
        key_pairs::Vector{Pair{EnvKeyString, String}} = collect(env_keys)
        new(version, filepath, key_pairs)
    end
end

# module EnvironmentVariables
