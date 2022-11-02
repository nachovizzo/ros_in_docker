# ROS in Docker

Tired of trying to compile ROS1 on Ubuntu 22.04? Tired of breaking your systems due to conflicts with
the ton of dependencies ROS1 has? Here we propose a solution. A completely isolated environment,
with ROS1 support by default, extensible, and with all the tools included for developing ROS1
applications without having to install them locally.

https://user-images.githubusercontent.com/21349875/199551739-c33dee77-57c7-4c10-a272-c60b98645368.mp4

# Tested host-machines

- Ubuntu 22.04

## Supported development environments

- [x] tmux
- [ ] VSCode

## GUI Supported?

Of course, you can run `rviz` and friends inside the dev container, it looks a bit ugly but at least
it works.

## Install host-machine dependencies

For now, you only need, I expect this repo to be used by "intermediate" developers, so I guess you
can figure out how to do that.

- Docker
- docker-compose

## How to use with your project

1. Click on "Use this template", or fork if you like.
1. Git clone the repo locally and `cd` into it.
1. Launch `make docker` to create a local docker container image with all the nice stuff installed.
   If you need any extra dependency, now is the time to add it to the [Dockerfile](./Dockerfile).
1. Create an `src/` directory inside the repository.
1. Clone inside the `src/` directory the ROS1 code you want to develop/test. I will be using the
   [ros_tutorials](https://github.com/ros/ros_tutorials) as an example, but it can be as complex as
   you wish.
1. Launch `make`, this will build your project and open a `tmux` session with all the batteries
   included.

## Security concerns

The entire setup is NOT safe at all, so, use it at your own risk. I'm mounting directories from the
host machine to the docker container where the user has `sudo` access without a password. So you can
literally delete some stuff with `root` permissions without even typing a password. So, you are
warned!

## About the tools for development

I built this project on top of my [dotfiles](https://github.com/nachovizzo/dotfiles/blob/main/.config/yadm/bootstrap),
so it's completely overfitted to my own needs and I don't intend to provide support for extra stuff.
If there is something you don't like or don't need, feel free to modify your copy of the Dockerfile.
You are in full control of what you want and not.

