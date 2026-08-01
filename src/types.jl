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
