module GPLVM_plus_dataset

    using Interpolations
    using Glob, FITSIO, Printf, JLD2
    using Statistics
    using DelimitedFiles
    using Artifacts, LazyArtifacts
    using ProgressMeter, Suppressor
    
    include("shift_to_restframe_and_interpolate.jl")
    include("preparedata_for_gplvm.jl")
    include("downloaddata.jl")
    include("loaddataasarrays.jl")
    include("loadstripe82dataset.jl")

    
    export downloaddata, loadstripe82dataset
end
