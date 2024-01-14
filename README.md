# sage-with-packages
A docker image containing Sage, and some other packages necessary for my research.

# Usage
You can pull this image from Docker Hub using `docker pull sayantankhan/sage-with-packages` or the equivalent `podman`
command. The following command runs the Jupyter server on local port 8888 and in the \<notebook-directory\> folder.

    podman run --privileged -it --rm -v <notebook-dir>:/root/notebooks:Z -p 8888:8888 localhost/ubuntu:sage 

