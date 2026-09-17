#!/usr/bin/env bash
set -eo pipefail

script_path=$(readlink -f -- "${BASH_SOURCE[0]}")
catalog_root=$(cd -- "$(dirname -- "$script_path")/.." && pwd -P)

required_models=(
    competition_models/ro1
    competition_models/ro2
    competition_models/cp
    competition_models/traffic_light
    competition_models/traffic_light_red_lens
    competition_models/traffic_light_yellow_lens
    competition_models/traffic_light_green_lens
    competition_models/map_plane
    competition_models/my_ground_plane
    competition_models/map_walls
    robot/competition_car
)

for model_dir in "${required_models[@]}"; do
    test -f "$catalog_root/$model_dir/model.config"
    test -f "$catalog_root/$model_dir/model.sdf"
done

test -f "$catalog_root/robot/xacro/gazebo_car_union.xacro"
test -f "$catalog_root/vision_models/person/person.onnx"
test -f "$catalog_root/vision_models/rapidocr/PP-OCRv6_det_small.onnx"
test -f "$catalog_root/vision_models/rapidocr/PP-OCRv6_rec_small.onnx"
test -f "$catalog_root/vision_models/rapidocr/ch_ppocr_mobile_v2.0_cls_mobile.onnx"
test -f "$catalog_root/worlds/model_gallery.world"

echo "Catalog check passed: ${#required_models[@]} Gazebo model entries plus robot sources and vision weights."
