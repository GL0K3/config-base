# Use the latest Arch Linux base image
FROM archlinux:latest

# Update the system and install necessary packages
RUN pacman -Syu --noconfirm \
    && pacman -S --noconfirm ansible git sudo

# Setup a non-root user to run Ansible playbooks
RUN useradd -m -G wheel -s /bin/bash ansibleuser \
    && echo "ansibleuser ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/ansibleuser

# Set working directory
WORKDIR /home/ansibleuser

# Switch to the new user
USER ansibleuser

# Copy the local Ansible playbooks directory to the container
# Make sure to place your playbooks in the 'playbooks' directory relative to the Dockerfile
COPY . /home/ansibleuser/config-base

RUN sudo chown -R ansibleuser:ansibleuser /home/ansibleuser/config-base

RUN mkdir -p /home/ansibleuser
RUN echo "1123" >> /home/ansibleuser/.vault_pass

ENV ANSIBLE_VAULT_PASSWORD_FILE=/home/ansibleuser/.vault_pass

RUN ansible-playbook -e ansible_user=$(whoami) /home/ansibleuser/config-base/nvim/setup.yml

RUN ansible-playbook -e ansible_user=$(whoami) /home/ansibleuser/config-base/tmux/setup.yml

RUN ansible-playbook -e ansible_user=$(whoami) /home/ansibleuser/config-base/proxy/setup.yml

RUN ansible-playbook -e ansible_user=$(whoami) /home/ansibleuser/config-base/bash/setup.yml

RUN ansible-playbook -e ansible_user=$(whoami) /home/ansibleuser/config-base/fish/setup.yml

# Set the default command or entrypoint, here we just idle so you can exec into the container
CMD ["sleep", "infinity"]

