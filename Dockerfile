# Dockerfile for sage notebook
# Use the following one-liner to run it locally
# docker run -it --rm --user 1000:$(id -g) --group-add sage-user -v <notebook-directory>:/home/sage-user -p 8888:8888 <container-id>
FROM ubuntu:latest

ENV TZ=America/Detroit
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && \
    apt-get install -y build-essential ppl-dev libpari-dev python3-dev python3-pip libntl-dev git && \
    apt-get install -y sagemath sagemath-jupyter sagemath-doc dvipng ffmpeg imagemagick && \
    pip3 install surface_dynamics sage-flatsurf flipper && \
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/flatsurf/veerer.git && \
    cd veerer && \
    python3 setup.py install

#RUN groupadd -g 1000 sage-user && \
#    useradd -m -u 1000 -g 1000 sage-user
WORKDIR /root
#USER sage-user
RUN mkdir -p  /root/.sage/jupyter-4.1
COPY ./jupyter_notebook_config.py /root/.sage/jupyter-4.1/jupyter_notebook_config.py
EXPOSE 8888

CMD ["sage", "-n", "jupyter", "--allow-root", "--no-browser", "--ip=0.0.0.0"]
