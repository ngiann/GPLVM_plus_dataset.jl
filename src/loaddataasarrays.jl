function loaddataasarrays()

    # Read wavelengths, fluxes, errors and redshift from files

    lcpath = joinpath(dirname(pathof(GPLVM_plus_dataset)), "data/")#"src/Data/"

    filenames = glob("*.fits", lcpath)

    # sanity check
    @assert(length(unique(filenames)) == length(filenames))
    
    lambda = map(filenames) do filename
        f = FITS(filename)
        10.0.^read(f[2],"loglam")
    end


    flux = map(filenames) do filename
        f = FITS(filename)
        read(f[2],"flux")
    end

    stderr = map(filenames) do filename
        f = FITS(filename)
        sqrt.(1.0./read(f[2],"ivar")) # ivar is inverse variance
    end

    z = map(filenames) do filename
        f = FITS(filename)
        read(f[3],"Z")
    end

    # find minimum common wavelength

    lmax = minimum([l[end] for l in lambda])

     # find maximum common wavelength

    lmin = maximum([l[1] for l in lambda])

    isbetween(x) = x>=lmin && x<=lmax

    # cut the data so that we only include common portions

    newflux = map(zip(lambda,flux)) do (l,f)

        idx = findall(isbetween, l)

        Vector{Union{Float64, Missing}}(f[idx])

    end

    newlambda = map(lambda) do l

        idx = findall(isbetween, l)

        Vector{Union{Float64, Missing}}(l[idx])

    end

    newstd = map(zip(lambda,stderr)) do (l,s)

        idx = findall(isbetween, l)

        Vector{Union{Float64, Missing}}(s[idx])

    end

    

    # make sure all wavelengths are identical,
    # i.e. all spectra have been sampled at the
    # same wavelengths
    for l in newlambda
        @assert(all(newlambda[1].==l))
    end

    fluxarray = reduce(hcat, newflux)
    stdarray  = reduce(hcat, newstd)

    # if there are any zero values in the standard deviations
    # replace them, and the correspinding flux values too, with missing.
    let
        idx = findall(isinf, stdarray)
        stdarray[idx]  .= missing
        fluxarray[idx] .= missing
    end

    return newlambda[1], fluxarray, stdarray, reduce(vcat,z), filenames
end