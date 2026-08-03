using EnvironmentVariables
using .EnvironmentVariables: EnvKeyString
using Markdown

# ../sources : julia directory
doc_filepath = normpath(@__DIR__, "../sources/doc/src/manual/environment-variables.md")

function apply_doc(f, io::IO, key::EnvKeyString, content)
    f(io, key, content)
end

function gen_help_doc(f, io::IO, md::Markdown.MD)::Vector{EnvKeyString}
    all_keys = Vector{EnvKeyString}()
    cur_key = nothing
    cur_content = []
    for c in md.content
        if c isa Markdown.Header{3}
            cur_key !== nothing && apply_doc(f, io, cur_key, cur_content)
            s = Markdown.plain(c)
            m = match(r"`(\w*)`", s)
            if m === nothing
                cur_key = nothing 
                cur_content = []
            else
                var_name = m[1]
                cur_key = EnvKeyString(var_name)
                push!(all_keys, cur_key)
                cur_content = []
            end
        else
            if cur_key !== nothing
                s = Markdown.plain(c)
                push!(cur_content, s)
            end
        end
    end
    cur_key !== nothing && apply_doc(f, io, cur_key, cur_content)
    all_keys
end

function write_jl(io::IO, key::EnvKeyString, content)
    q = repeat('"', 3)
    println(io)
    print(io, q, replace(join(content), '$' => "\\\$"), q)
    println(io)
    print(io, "const ", key.s, " = ")
    print(io, key)
    println(io)
end

function write_docs_jl(doc_filepath)
    doc_string = read(doc_filepath, String)
    md = Markdown.parse(doc_string; flavor=:julia)
    io = IOBuffer()
    all_keys = gen_help_doc(write_jl, io, md)
    content = String(take!(io))
    exports = join(map(key -> key.s, all_keys), ", ")

    output = """
# generated 
# docs from julia/doc/src/manual/environment-variables.md
module Docs # EnvironmentVariables

export $exports

using ..EnvironmentVariables: EnvKeyString
$content
end # module EnvironmentVariables.Docs
"""
    filepath = normpath(@__DIR__, "Docs.jl")
    @info "save Docs.jl" filepath
    write(filepath, output)
end # function write_docs_jl

if true # false
write_docs_jl(doc_filepath)
end
