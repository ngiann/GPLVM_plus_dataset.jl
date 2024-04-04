function downloaddata()

       @printf("wget must be installed in order for this to work!\n")

       if Threads.nthreads() == 1
              @printf("""Start Julia with multiple threads in order to download data in parallel, e.g. "julia -t4" starts julia with 4 threads.\n""")
       else
              @printf("Downloading data with %d available workers.\n", Threads.nthreads())
       end

       # file wget_nikos_sample.txt is a catalogue created by Iliana

       lcpath = dirname(pathof(GPLVM_plus_dataset))

       lines = readlines(joinpath(lcpath, "wget_nikos_sample.txt"))

       pr = Progress(length(lines))

       Threads.@threads for x in lines
              V = map(String, split(x))
              cd(lcpath*"/data/")
              run(Cmd(V))
              next!(pr)
       end
       finish!(pr)

end