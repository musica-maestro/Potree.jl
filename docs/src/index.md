# Potree.jl

*A [potree](https://github.com/potree/potree/) struct manager for julia.*

## !!! note
That's an enhanced version of [FileManager.jl](https://github.com/marteresagh/FileManager.jl) made by [marteresagh](https://github.com/marteresagh)

## Package Features

- Multithreaded loading of Potree (1.7) made of .bin, .las and .laz files.
- Testing of main functions in this package

This documentation provides an explaination on how Potree.jl works.

Some examples of packages using Documenter can be found on the examples folder in this packagee.

## SRC file tree

The source folder could be devided into 2 parts: loading and managing.
Into the loading folder there are 4 files with the main apis.
Into the managing part there are the useful functions to manage the potree struct and the file searching.

📦src\
 ┣ 📂Load\
 ┃ ┣ 📜bin.jl\
 ┃ ┣ 📜hierarchy.jl\
 ┃ ┣ 📜json.jl\
 ┃ ┗ 📜las.jl\
 ┣ 📜Potree.jl\
 ┣ 📜struct.jl\
 ┗ 📜utilities.jl\