# ROS in Docker

Tired of trying to compile ROS1 on Ubuntu 22.04? Tired of breaking your systems due conflicts with
the ton of dependencies ROS1 has? Here we proposse a solution. A completely isolated environvemt,
with ROS1 support by default, extensible and with all the tools included for develop ROS1
applications withouth having to install it locally.

# Tested host-machines

- Ubuntu 22.04

## Supported development environvemts

- [x] tmux
- [ ] VSCode

## GUI Supported?

Of course, you can run `rviz` and friends inside the dev container, it looks a bit ugly but at least
it works.

## Install host-machine dependencies

For now you only need, I expect this repo to be used by "intermediate" developers, so I guess you
can figure out yourself how to do that.

- docker
- docker-compose

## How to use with your project

1. Click on "Use this tempalte", or fork if you like.
1. Git clone the repo locally and `cd` into it.
1. Launch `make docker` to create a local docker container image with all the nice stuff insalled.
   If you need any extra dependency, now is the time to add it to the [Dockerfile](./Dockerfile).
1. Create a `src/` directory inside the repository.
1. Clone inside the `src/` directory the ROS1 code you want to develop/test. I will be using the
   [ros_tutorials](https://github.com/ros/ros_tutorials) as an example, but it can be as complex as
   you wish.
1. Launch `make`, this will build your project and open a `tmux` session with all the batteries
   included.

## Security concerns

The entire setup is NOT safe at all, so, use it at your own risk. I'm mounting directories from the
host machine to the docker container where the user has `sudo` acess without a password. So you can
literraly delete some stuff with `root` permissions withouth even typing a password. So, you are
warned!

## About the tools for development

I built this projecct on top of my [dotfiles](https://github.com/nachovizzo/dotfiles/blob/main/.config/yadm/bootstrap),
so it's completely overfitted to my own needs and I don't intend to proivde support for extra stuff.
If there is something you don't like or don't need, feel free to modify your copy of the Dockerfile.
You are in full controll of what you want and not.
