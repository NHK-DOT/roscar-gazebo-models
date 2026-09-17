#!/usr/bin/env bash

# Source this file to use every model directly from the cloned repository.
roscar_models_root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)

case ":${GAZEBO_MODEL_PATH:-}:" in
    *":$roscar_models_root/competition_models:"*) ;;
    *) export GAZEBO_MODEL_PATH="$roscar_models_root/competition_models${GAZEBO_MODEL_PATH:+:$GAZEBO_MODEL_PATH}" ;;
esac

case ":${GAZEBO_MODEL_PATH:-}:" in
    *":$roscar_models_root/robot:"*) ;;
    *) export GAZEBO_MODEL_PATH="$roscar_models_root/robot${GAZEBO_MODEL_PATH:+:$GAZEBO_MODEL_PATH}" ;;
esac

unset roscar_models_root
