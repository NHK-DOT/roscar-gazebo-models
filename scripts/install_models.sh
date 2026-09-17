#!/usr/bin/env bash
set -eo pipefail

script_path=$(readlink -f -- "${BASH_SOURCE[0]}")
catalog_root=$(cd -- "$(dirname -- "$script_path")/.." && pwd -P)
destination=${1:-"$HOME/.gazebo/models"}

model_sources=(
    competition_models/cp
    competition_models/map_plane
    competition_models/map_walls
    competition_models/my_ground_plane
    competition_models/ro1
    competition_models/ro2
    competition_models/traffic_light
    competition_models/traffic_light_red_lens
    competition_models/traffic_light_yellow_lens
    competition_models/traffic_light_green_lens
    robot/competition_car
)

mkdir -p -- "$destination"

conflicts=0
for relative_source in "${model_sources[@]}"; do
    source_dir="$catalog_root/$relative_source"
    model_name=$(basename -- "$source_dir")
    target_dir="$destination/$model_name"

    if [[ -e "$target_dir" || -L "$target_dir" ]]; then
        echo "Conflict: $target_dir already exists; nothing was overwritten." >&2
        conflicts=$((conflicts + 1))
    fi
done

if (( conflicts > 0 )); then
    echo "Installation stopped because $conflicts model path(s) already exist." >&2
    exit 1
fi

for relative_source in "${model_sources[@]}"; do
    source_dir="$catalog_root/$relative_source"
    cp -a -- "$source_dir" "$destination/"
    echo "Installed: $(basename -- "$source_dir")"
done

echo "Installed ${#model_sources[@]} Gazebo models into $destination"
