# 模型资产清单

导出源：`/home/yz/ros1_noetic/roscar_first_ws/src/jubot_demo`

## 正式比赛场景模型

| 分类 | Gazebo URI / 文件 | 内容 | 依赖 | 当前用途 |
| --- | --- | --- | --- | --- |
| 人物立牌 | `model://ro1` | 人物立牌一，约 `1.0 x 0.1 x 0.5 m` | `ro1.dae`、`rodesign0.png` | 人物识别点一 |
| 人物立牌 | `model://ro2` | 人物立牌二，约 `1.0 x 0.1 x 0.5 m` | `ro2.dae`、`rodesign1.png` | 人物识别点二 |
| 车辆立牌 | `model://cp` | 车辆与车牌立牌，约 `0.7 x 0.04 x 0.5 m` | `cp.dae`、`cp.png`、`car.jpg` | 车辆和车牌识别 |
| 红绿灯主体 | `model://traffic_light` | 双脚横向龙门架，左红、中黄、右绿 | 纯 SDF 几何 | 两处斑马线灯架 |
| 红灯灯片 | `model://traffic_light_red_lens` | 动态高亮红色灯片 | 纯 SDF 几何 | 控制器按状态显示 |
| 黄灯灯片 | `model://traffic_light_yellow_lens` | 动态高亮黄色灯片 | 纯 SDF 几何 | 控制器按状态显示 |
| 绿灯灯片 | `model://traffic_light_green_lens` | 动态高亮绿色灯片 | 纯 SDF 几何 | 控制器按状态显示 |
| 原始地图地面 | `model://map_plane` | 从原 ROS 1 项目恢复的 `4.2 x 4.2 m` 地面 | `map.jpg` 等贴图 | 当前比赛 world 使用 |
| 路线地面 | `model://my_ground_plane` | 重新整理的 `4.2 x 4.2 m` 路线地面 | `route_ground.png`、`route_ground_v2.png` | 路线贴图备选/对照 |
| 比赛围墙 | `model://map_walls` | 四面边界墙，外轮廓约 `4.3 x 4.3 m`、高 `0.7 m`、厚 `0.1 m` | 纯 SDF 几何 | 从 world 内嵌 `map_one` 原样提取 |
| 比赛小车 | `robot/xacro/gazebo_car_union.xacro` | 四轮滑移小车、相机、雷达和驱动插件 | 全部 Xacro 文件 | 当前仿真机器人 |

红绿灯的四个目录是一个完整组件：主体提供灯架和暗色灯面，三个灯片由控制节点移动到显示位置或隐藏位置。复制模型时不能只复制 `traffic_light`。

## 已排除模型

应用户要求，本导出不包含历史 `model://stop_light`、`model://stop_light_post` 和测试 `model://road_obstacle`。原比赛工作区仍保留这些文件，以免破坏旧验证入口；正式比赛 world 本来就不使用这些历史灯和测试路障。

## 非 Gazebo 模型

`vision_models/person/person.onnx` 和 `vision_models/rapidocr/*.onnx` 是人物检测与 OCR 推理权重，不包含 SDF、网格或贴图。它们从原项目的 `models/` 中单独移出，避免与 Gazebo 资产混淆。

## 小车差异会造成的影响

`armbot` 是 URDF 内部机器人名；比赛 world 中的实体名是 `mycar`。名称不同通常没有影响，因为插件使用根命名空间，导航仍通过 `base_footprint`、`/cmd_vel` 和 `/odom` 工作。

如果你说的“不同”是外形或硬件布局不同，则会有实际影响：

1. 车身和轮距不同会改变转弯半径、狭窄通道通过能力和里程计尺度。
2. 碰撞体不同会改变 Gazebo 碰撞结果；导航的机器人半径也应与真实包络一致。
3. 相机高度、朝向或视场角不同会改变人物、车辆、车牌和红绿灯在图像中的尺寸与出现时机。
4. 雷达高度和扫描范围不同会改变墙体、立牌和路障的点云/激光轮廓。
5. TF、关节名、插件或话题不同会直接导致导航、驱动或传感器节点无法连接。

当前导出忠实保留现有比赛项目的小车，不在模型整理过程中改车体参数。
