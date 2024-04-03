function preparedata_for_gplvm(numgridpoints=1000)

    λgrid, restframespectra, files = shift_to_restframe_and_interpolate(numgridpoints)
   
    # sanity check
    
    @assert(length(unique(files)) == length(files))

    lcpath = dirname(pathof(GPLVM_plus_dataset))

    tbl = readdlm(lcpath * "/normalization_1000sample.txt",skipstart=1) # load Iliana's table

    getindex(x) = only(findall(contains.(files, x)))

    sdss_id = tbl[:, 1]; @assert(length(unique(sdss_id)) == length(sdss_id)) # sanity check
    
    

    area = map(Float64,tbl[:, 3]) # area under continuum and line calculated by Iliana's model

    area = area / minimum(area) # make numbers more manageable, only relative magnitude matters

    power_cont = map(Float64, tbl[:, 4])

    scale_cont = map(Float64, tbl[:, 5])

    for index in 1:size(tbl, 1)

        restframespectra[getindex(sdss_id[index])] /= area[index]

    end

    newindices = map(i->getindex(sdss_id[i]), 1:size(tbl, 1))

    # re-order data so that data follow indices of entries in table
    λgrid, restframespectra[newindices], sdss_id, area, scale_cont, power_cont

end