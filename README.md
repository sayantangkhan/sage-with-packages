# sage-with-packages
A docker image containing Sage, and some other packages necessary for my research.

# Usage
You can pull this image from Docker Hub using `docker pull sayantankhan/sage-with-packages` or the equivalent `podman`
command. The following command runs the Jupyter server on local port 8888 and in the \<notebook-directory\> folder.

    docker run -it --rm --user 1000:$(id -g) --group-add sage-user -v \<notebook-directory\>:/home/sage-user -p 8888:8888 \<container-id\>

To run this container with podman, you need to run it with the `--privileged` flag to enable write access on the notebook directory.
