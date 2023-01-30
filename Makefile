# MIT License
#
# Copyright (c) 2022 Ignacio Vizzo
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
.PHONY:build clean dev docker run
CONTAINER_NAME?=noetic
export CONTAINER_NAME

default:build
	@docker-compose run --rm ros tmuxinator

dev:
	@docker-compose run --rm ros tmuxinator

build:
	@docker-compose run --rm ros catkin init 
	@docker-compose run --rm ros catkin build --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
	@docker-compose run -w /home/user/ros_ws/build/ --rm ros merge_compile_commands

docker:
	docker build -t ros_in_docker/noetic:$(CONTAINER_NAME) .

clean:
	@docker-compose run --rm ros catkin clean

run:
	@docker-compose run -e "TERM=xterm-256color" --rm ros
