using Documenter, Potree

Documenter.makedocs(
    format = Documenter.HTML(
		prettyurls = get(ENV, "CI", nothing) == "true"
	),
sitename = "Potree.jl",
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