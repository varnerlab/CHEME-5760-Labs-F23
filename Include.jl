# setup the paths -
const _ROOT = pwd();
const _PATH_TO_SRC = joinpath(_ROOT, "src");
const _PATH_TO_DATA = joinpath(_ROOT, "data");

# download external packages
import Pkg; Pkg.activate("."); Pkg.instantiate(); Pkg.update()

# load external packages -
using VLDecisionsPackage
using CSV
using DataFrames
using ForwardDiff
using PrettyTables
using Plots
using Colors
using Statistics
using LinearAlgebra
using Optim
using StatsPlots
using Distributions

# load my codes -
include(joinpath(_PATH_TO_SRC, "Compute.jl"));
include(joinpath(_PATH_TO_SRC, "Files.jl"));
