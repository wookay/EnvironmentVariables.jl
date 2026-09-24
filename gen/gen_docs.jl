using EnvironmentVariables
include(normpath(@__DIR__, "src_patches.jl"))
include(normpath(@__DIR__, "base_patches.jl"))
include(normpath(@__DIR__, "stdlib_patches.jl"))

using Markdown: MD, Header, Table, Code, List, Link, Paragraph, htmlesc, @md_str

const generated_comments = """
```@raw html
<!-- generated -->
```
"""

function gen_patches(title::String, patches)
    contents = []
    for patch in patches
        env_key_added = []
        for pair in patch.key_pairs
            env_key = pair.first.s
            if env_key ∈ env_key_added
            else
                push!(env_key_added, env_key)
            end
        end
        h3 = string("`", patch.version, " ", join(env_key_added, ", "), "`")
        push!(contents, Header{3}(h3))
        push!(contents, Paragraph(
            string(
                "**", patch.filepath.s, "**",
                "\$~~~~~~~~~~~\$",
                " ( julia commit ",
                "[", patch.commit, "](", "https://github.com/JuliaLang/julia/commit/", patch.commit, ")",
                " )",
            )
        ))
        for env_key in env_key_added
            push!(contents, List(Code("", env_key)))
        end
    end
    contents
end

function add_doc_top(title, filename)
    """
# $title

```@contents
Pages = ["$filename"]
Depth = 2:3
```

```@index
Pages = ["$filename"]
```
"""
end

function write_doc_src_patches(name::Symbol)
    filename = string(name, ".md")
    filepath = normpath(@__DIR__, "../docs/src/$filename")
    subs = []
    for (title, patches) in [
            ("src/", SRC_PATCHES)
            ("cli/", CLI_PATCHES)]
        contents = gen_patches(title, patches)
        sub = [Header{2}(title), contents...]
        push!(subs, sub)
    end
    title = "src/ cli/ ENV variables"
    doc_top = add_doc_top(title, filename)
    md = MD(subs...)
    @info "save $title" filepath
    write(filepath, string(generated_comments, "\n", doc_top, "\n", md))
end

function write_doc_base_patches(name::Symbol)
    filename = string(name, ".md")
    filepath = normpath(@__DIR__, "../docs/src/$filename")
    subs = []
    for (title, patches) in [
            ("base/", BASE_PATCHES)]
        contents = gen_patches(title, patches)
        sub = [Header{2}(title), contents...]
        push!(subs, sub)
    end
    title = "base/ ENV variables"
    doc_top = add_doc_top(title, filename)
    md = MD(subs...)
    @info "save $title" filepath
    write(filepath, string(generated_comments, "\n", doc_top, "\n", md))
end

function write_doc_stdlib_patches(name::Symbol)
    filename = string(name, ".md")
    filepath = normpath(@__DIR__, "../docs/src/$filename")
    subs = []
    for (title, patches) in [
            ("Test", STDLIB_Test_PATCHES)
            ("REPL", STDLIB_REPL_PATCHES)]
        contents = gen_patches(title, patches)
        sub = [Header{2}(title), contents...]
        push!(subs, sub)
    end
    title = "STDLIB ENV variables"
    doc_top = add_doc_top(title, filename)
    md = MD(subs...)
    @info "save $title" filepath
    write(filepath, string(generated_comments, "\n", doc_top, "\n", md))
end

if true # false
write_doc_src_patches(:src_patches)
write_doc_base_patches(:base_patches)
write_doc_stdlib_patches(:stdlib_patches)
end
