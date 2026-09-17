#!/usr/bin/env bash
set -eo pipefail

script_path=$(readlink -f -- "${BASH_SOURCE[0]}")
catalog_root=$(cd -- "$(dirname -- "$script_path")/.." && pwd -P)

runtime_candidates=(
    "${ROSCAR_WORKSPACE:-}/scripts/runtime_env.sh"
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

if [[ -z "$runtime_script" ]]; then
    echo "ROSCar ROS 1 runtime_env.sh was not found." >&2
    echo "Set ROSCAR_WORKSPACE to the roscar_first_ws directory." >&2
    exit 1
fi

source "$runtime_script"
if [[ -f "$ROS1_WORKSPACE/devel/setup.bash" ]]; then
    source "$ROS1_WORKSPACE/devel/setup.bash"
fi

export GAZEBO_MODEL_CATALOG=$catalog_root
export GAZEBO_MODEL_PATH="$catalog_root/competition_models:$catalog_root/robot${GAZEBO_MODEL_PATH:+:$GAZEBO_MODEL_PATH}"

exec roslaunch "$catalog_root/launch/model_gallery.launch" "$@"
