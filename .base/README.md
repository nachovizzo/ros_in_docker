# Docker base

This container serves as the base for all the applications which uses the ros_in_docker template
repo. The idea is that you should not modify it unless you know what you are doing. For most
applications just change the user-level [Dockerfile](../Dockerfile).

## Supported ROS distribution

For now, I only care about the latest LTS supported ROS1 distribution: **Noetic**
