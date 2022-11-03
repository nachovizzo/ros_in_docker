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
FROM osrf/ros:noetic-desktop-full
LABEL maintainer="Ignacio Vizzo <ignaciovizzo@gmail.com>"
ENV USER_NAME="user"
ENV GROUP_ID=1000
ENV USER_ID=1000

# Use local mirrors for faster deployment
RUN sed -i -e 's/http:\/\/archive\.ubuntu\.com\/ubuntu\//mirror:\/\/mirrors\.ubuntu\.com\/mirrors\.txt/' /etc/apt/sources.list

# Install bare-minumin tools to bootstrap the installation
RUN apt-get update && apt-get install --no-install-recommends -y \
    curl \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Add normal sudo-user to container, passwordless
RUN addgroup --gid $GROUP_ID $USER_NAME \
    && adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID $USER_NAME \
    && adduser $USER_NAME sudo \
    && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
    && sed -i 's/required/sufficient/' /etc/pam.d/chsh \
    && touch /home/$USER_NAME/.sudo_as_admin_successful

# Switch to local user and bootstrap the dev installation
USER $USER_NAME

# Run the magic bootstrap script
RUN sh -c \
    "$(curl -fsSL https://raw.githubusercontent.com/nachovizzo/dotfiles/main/tools/install.sh)" "" \
    --full --skip-decrypt

# Insall catkin tools
RUN python3 -m pip install --user --upgrade catkin-tools

# Finish setup
RUN echo 'source /home/$USER_NAME/ros_ws/devel/setup.zsh 2>/dev/null || true' > /home/$USER_NAME/.zshrc_local
RUN sed -i 's/\"fwalch\"/\"agnoster\"/' /home/$USER_NAME/.zshrc
COPY ./ros_entrypoint.sh /
ENTRYPOINT ["/ros_entrypoint.sh"]
WORKDIR /home/$USER_NAME/ros_ws
CMD ["zsh"]
