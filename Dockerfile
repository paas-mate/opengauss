FROM shoothzj/base:openeuler

RUN dnf install -yq util-linux && \
    dnf install -y libaio && \
    dnf install -y glibc-locale-source && \
    dnf clean all

RUN groupadd gauss -g 777 && \
    useradd -r -g gauss gauss -u 777 -m -d /opt/gauss && \
    touch /opt/gauss/.bashrc && \
    localedef --no-archive -i en_US -f UTF-8 en_US.UTF-8

RUN ln -s /usr/lib64/libreadline.so.8 /usr/lib64/libreadline.so.7;

USER gauss

WORKDIR /opt/gauss

ARG TARGETARCH
ARG amd_download=5.0.3/x86_openEuler_2203/openGauss-5.0.3-openEuler-64bit.tar.bz2
ARG arm_download=5.0.3/arm_2203/openGauss-5.0.3-openEuler-64bit.tar.bz2

RUN if [ "$TARGETARCH" = "amd64" ]; \
    then download=$amd_download; \
    else download=$arm_download; \
    fi && \
    wget -q https://opengauss.obs.cn-south-1.myhuaweicloud.com/$download && \
    tar -xf openGauss-5.0.3-openEuler* -C /opt/gauss && \
    rm -rf openGauss-5.0.3-openEuler*
