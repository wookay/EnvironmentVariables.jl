# module EnvironmentVariables

function Base.show(io::IO, mime::MIME"text/plain", key::EnvKeyString)
    md = Base.Docs.doc(Base.Docs.Binding(Docs, Symbol(key.s)))
    Base.show(io, mime, md)
end

# module EnvironmentVariables
