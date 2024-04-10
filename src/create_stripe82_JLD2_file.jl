function create_stripe82_JLD2_file()

    λ, restframespectra, restframestd, sdss_id, area, scale_continuum, power_continuum = preparedata_for_gplvm();

    JLD2.save("stripe82data.jld2","λcommon",λ,"restframespectra",restframespectra,"restframestd",restframestd,"sdss_id",sdss_id,"area",area,"scale_continuum",scale_continuum,"power_continuum",power_continuum)

end