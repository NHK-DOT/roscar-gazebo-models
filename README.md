# Gazebo Model Catalog

本目录是智慧社区 ROS 1 仿真项目的独立模型导出，不会修改系统 Gazebo 模型目录，也不会改变原比赛地图。

模型来源基于 [xyls999/roscar-first](https://github.com/xyls999/roscar-first)、已恢复的 ROS 1 虚拟机工程以及本项目后续整理。上游工程未提供明确的软件/素材许可证，因此本仓库默认按私有项目管理，公开或再分发前应先确认相关授权。

## 一键查看

```bash
cd /home/yz/ros1_noetic/gazebo_model_catalog
./scripts/launch_gallery.sh
```

关闭展厅时在启动终端按 `Ctrl+C`。详细资产用途和来源见 [MODEL_CATALOG.md](MODEL_CATALOG.md)。

## 目录结构

```text
competition_models/  正式场景中的人物、车辆立牌、红绿灯、围墙和地面
robot/               当前比赛小车的 Xacro、展开 URDF 和 Gazebo SDF
vision_models/       ONNX 视觉模型，不属于 Gazebo 几何模型
worlds/              独立模型展厅
launch/              ROS 1 展厅启动文件
scripts/             一键启动和完整性检查
screenshots/         展厅验证截图
```

所有 `model://...` 目录名均保持原样。启动脚本会设置 `GAZEBO_MODEL_PATH`，因此贴图引用不会失效。历史 `stop_light`/`stop_light_post` 和测试 `road_obstacle` 已按要求从本导出中移除。

## 小车名称说明

- Xacro 根节点名称是 `armbot`。
- 原比赛启动文件将 Gazebo 实体生成为 `mycar`。
- 本展厅把同一套模型命名为 `competition_car`，便于与其他展品区分。

这三个名称不同不会改变外形、驱动或导航接口。真正影响行为的是几何尺寸、轮距轮径、碰撞体、传感器安装位置、TF 帧、ROS 话题和 Gazebo 驱动插件。

当前导出的小车保持项目实际参数：车身 `0.30 x 0.20 x 0.08 m`、轮径 `0.16 m`、轮中心距约 `0.264 m`，使用 `/cmd_vel`、`/odom`、`/scan`、`/camera/image_raw` 和 `base_footprint`。
