#!/usr/bin/env bash

# Source our workspace directory to load ENV variables
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source ${SCRIPT_DIR}/../../../devel/setup.bash

# dataset locations
bagnames=(
    "lab1"
    "lab2"
)

# Location to save log files into
save_path1="$SCRIPT_DIR/../results/realsense_d435i/algorithms"
log_path="$SCRIPT_DIR/../results/realsense_d435i/temp"
bag_path="/home/mitchell/Documents/data/d435i_mcgill"

truth_path="/home/mitchell/Documents/data/d435i_mcgill/truths"

mkdir -p "$truth_path"

for i in "${!bagnames[@]}"; do

echo "Processing ${bagnames[i]}"

stats_path_states="$truth_path/${bagnames[i]}.csv"
bag_file="$bag_path/${bagnames[i]}.bag"
stats_path_info="$log_path/vicon2gt_info.txt"

# Run the ROS launch file
roslaunch vicon2gt exp_realsense.launch \
  path_bag:="$bag_file" \
  folder:="$bag_path" \
  stats_path_states:="$stats_path_states" \
  stats_path_info:="$stats_path_info" \

end_time="$(date -u +%s)"
elapsed_time=$(( end_time - start_time ))
echo "Elapsed time: $elapsed_time seconds"

done
