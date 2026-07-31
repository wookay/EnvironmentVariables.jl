# module EnvironmentVariables

struct EnvVarEmptyNameError <: Exception
end

struct EnvVarString
    s::String
end

function valid_envvarstring(s)
    if isempty(s)
        throw(EnvVarEmptyNameError())
    else
        EnvVarString(s)
    end
end

macro EnvVar_str(s)
    quote
        valid_envvarstring($s)
    end
end

# module EnvironmentVariables
