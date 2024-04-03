function moving_average(data, window_size)
    smoothed_data = similar(data, length(data))
    half_window = div(window_size, 2)
    for i in 1:length(data)
        start_idx = max(1, i - half_window)
        end_idx = min(length(data), i + half_window)
        valid_values = filter(!ismissing, data[start_idx:end_idx])  # Filter out missing values
        if !isempty(valid_values)
            smoothed_data[i] = mean(valid_values)
        else
            smoothed_data[i] = missing
        end
    end
    return smoothed_data
end

function downsample(data, factor)
    downsampled_data = Vector{Union{eltype(data), Missing}}()
    for i in 1:factor:length(data)
        valid_values = filter(!ismissing, data[i:min(i+factor-1, end)])  # Filter out missing values
        if !isempty(valid_values)
            push!(downsampled_data, mean(valid_values))
        else
            push!(downsampled_data, missing)
        end
    end
    return downsampled_data
end

# # Smoothing parameters
# window_size = 3

# # Downsample factor
# downsample_factor = 2

# # Apply moving average smoothing
# smoothed_data = moving_average(data, window_size)

# Downsample the smoothed data
# downsampled_data = downsample(smoothed_data, downsample_factor)
