using Documenter, Potree

Documenter.makedocs(
sitename = "Potree.jl",
repo = "https://github.com/musica-maestro/Potree.jl",
authors = "Alessio Ferrato",
pages = [
    "Home" => "index.md",
    "Load" => [
        "bin.jl" => "bin.md",
        "hierarchy.jl" => "hierarchy.md",
        "json.jl" => "json.md",
        "las.jl" => "las.md"
        ]
    ]
)