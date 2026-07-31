# module EnvironmentVariables

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

# module EnvironmentVariables
