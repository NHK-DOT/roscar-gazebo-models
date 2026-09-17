#!/usr/bin/env bash
set -eo pipefail

script_path=$(readlink -f -- "${BASH_SOURCE[0]}")
catalog_root=$(cd -- "$(dirname -- "$script_path")/.." && pwd -P)

runtime_candidates=()
if [[ -n ${ROSCAR_WORKSPACE:-} ]]; then
    runtime_candidates+=("$ROSCAR_WORKSPACE/scripts/runtime_env.sh")
fi
runtime_candidates+=(
    "$catalog_root/../roscar_first_ws/scripts/runtime_env.sh"
    "$catalog_root/../roscar-first-handoff/workspace/scripts/runtime_env.sh"
)

runtime_script=""
for candidate in "${runtime_candidates[@]}"; do
    if [[ -n "$candidate" && -f "$candidate" ]]; then
        runtime_script=$candidate
        break
    fi
done

if [[ -n "$runtime_script" ]]; then
    source "$runtime_script"
elif [[ -f /opt/ros/noetic/setup.bash ]]; then
    source /opt/ros/noetic/setup.bash
elif ! command -v roslaunch >/dev/null 2>&1; then
    echo "ROS 1 Noetic was not found." >&2
    echo "Install ROS Noetic or set ROSCAR_WORKSPACE to a compatible workspace." >&2
    exit 1
fi

if [[ -n ${ROS1_WORKSPACE:-} && -f "$ROS1_WORKSPACE/devel/setup.bash" ]]; then
    source "$ROS1_WORKSPACE/devel/setup.bash"
fi

export GAZEBO_MODEL_CATALOG=$catalog_root
export GAZEBO_MODEL_PATH="$catalog_root/competition_models:$catalog_root/robot${GAZEBO_MODEL_PATH:+:$GAZEBO_MODEL_PATH}"

exec roslaunch "$catalog_root/launch/model_gallery.launch" "$@"
