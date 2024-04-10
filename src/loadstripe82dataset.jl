function loadstripe82dataset(;replacement = missing)

    data = JLD2.load(joinpath(artifact"stripe82data","stripe82data.jld2"))

    restframespectra = replace(reduce(hcat, data["restframespectra"]), Inf => replacement)

    restframestd     = replace(reduce(hcat, data["restframestd"]), Inf => replacement)

    @printf("Returning spectra, that have been shifted to the rest frame, as an array of size %d×%d.\n", size(restframespectra,1), size(restframespectra,2))
    @printf("Also returning common grid of wavelength values, valid for all spectra, and a unique string identifier.\n")

    @assert(length(data["λcommon"]) == size(restframespectra,1))
    @assert(length(data["λcommon"]) == size(restframestd,1))
    @assert(size(restframespectra) == size(restframestd))
    
    return restframespectra, restframestd, data["λcommon"], data["sdss_id"]
end