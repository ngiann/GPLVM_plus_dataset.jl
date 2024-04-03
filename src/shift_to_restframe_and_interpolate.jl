function shift_to_restframe_and_interpolate(numgridpoints=1000)

    # Read wavelengths, fluxes, errors and redshift from files

    λoriginal, spectra, stderr, Z, files = loaddataasarrays()

    # sanity check
    
    @assert(length(unique(files)) == length(files))

    # find minimum and maximum wavelength after redshift

    λmin = minimum(map(z->λoriginal[1]/(z+1), Z))
    λmax = minimum(map(z->λoriginal[end]*(z+1), Z)) + 100.0

    λgrid = collect(LinRange(λmin, λmax, numgridpoints))
    
    restframespectra = map(zip(eachcol(spectra),Z)) do (s, z)

        idx = findall(x -> ~ismissing(x), s)

        f = linear_interpolation(λoriginal[idx]/(z+1), s[idx], extrapolation_bc = Inf)

        f(λgrid)

    end


    λgrid, restframespectra, files

end