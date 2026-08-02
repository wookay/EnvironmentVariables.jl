using EnvironmentVariables
include(normpath(@__DIR__, "src_patches.jl"))
include(normpath(@__DIR__, "base_patches.jl"))
include(normpath(@__DIR__, "stdlib_patches.jl"))

using Markdown: MD, Header, Table, Code, List, Paragraph, htmlesc, @md_str

const generated_comments = """
```@raw html
<!-- generated -->
```
"""

function gen_patches(title::String, patches)
    contents = []
    for patch in patches
        push!(contents, Header{3}(patch.version))
        push!(contents, Paragraph(patch.filepath.s))
        env_key_added = []
        for pair in patch.key_pairs
            env_key = pair.first.s
            if env_key ∈ env_key_added
            else
                push!(contents, List(Code("", env_key)))
                push!(env_key_added, env_key)
            end
        end
    end
    contents
end

function write_doc_patches(patches, name::Symbol, title::String)
    filepath = normpath(@__DIR__, "../docs/src/$name.md")
    contents = gen_patches(title, patches)
    md = MD(Header{1}(title), contents...)
    @info "save $title" filepath
    write(filepath, string(generated_comments, md))
end

function write_doc_stdlib_patches(name::Symbol)
    filepath = normpath(@__DIR__, "../docs/src/$name.md")
    subs = []
    for (title, patches) in [
            ("Test", STDLIB_Test_PATCHES)
            ("REPL", STDLIB_REPL_PATCHES)]
        contents = gen_patches(title, patches)
        sub = [Header{2}(title), contents...]
        push!(subs, sub)
    end
    title = "STDLIB ENV variables"
    md = MD(Header{1}(title), subs...)
    @info "save $title" filepath
    write(filepath, string(generated_comments, md))
end

if true # false
write_doc_patches(SRC_PATCHES, :src_patches, "src/ ENV variables")
write_doc_patches(BASE_PATCHES, :base_patches, "base/ ENV variables")
write_doc_stdlib_patches(:stdlib_patches)
end
