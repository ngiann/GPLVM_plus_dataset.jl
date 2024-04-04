# GPLVM_plus_dataset

[![Build Status](https://github.com/ngiann/GPLVM_plus_dataset.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/ngiann/GPLVM_plus_dataset.jl/actions/workflows/CI.yml?query=branch%3Amain)

To generate the JLD2 file for the stripe82 dataset from scratch, start julia with multiple threads and use the following:
```
using GPLVM_plus_dataset

downloaddata()

create_stripe82_JLD2_file()
```

The created JLD2 file can be made into a Julia artifact file using ArtifactUtils.jl.