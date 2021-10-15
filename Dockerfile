# Dockerfile for sage notebook
# Use the following one-liner to run it locally
# docker run -it --rm --user 1000:$(id -g) --group-add sage-user -v <notebook-directory>:/home/sage-user -p 8888:8888 <container-id>
FROM ubuntu:latest

ENV TZ=America/Detroit
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && \
    apt-get install -y build-essential ppl-dev libpari-dev python3-dev python3-pip libntl-dev git && \
    apt-get install --no-install-recommends -y sagemath sagemath-jupyter sagemath-doc-en dvipng ffmpeg imagemagick && \
    pip3 install surface_dynamics sage-flatsurf && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get purge -y build-essential ppl-dev libpari-dev python3-dev libntl-dev

RUN git clone https://gitlab.com/videlec/veerer.git && \
    cd veerer && \
    python3 setup.py install

RUN groupadd -g 1000 sage-user && \
    useradd -m -u 1000 -g 1000 sage-user
WORKDIR /home/sage-user
USER sage-user
EXPOSE 8888

CMD ["sage", "-n", "jupyter", "--no-browser", "--ip=0.0.0.0", "--port=8888"]

