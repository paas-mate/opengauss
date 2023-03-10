FROM shoothzj/base

WORKDIR /opt

ARG TARGETARCH
ARG amd_download=x86_openEuler/openGauss-3.1.1-openEuler-64bit-all
ARG arm_download=arm/openGauss-3.1.1-openEuler-64bit-all
ARG amd_file=openGauss-3.1.1-openEuler-64bit-all
ARG arm_file=openGauss-3.1.1-openEuler-64bit-all

RUN if [ "$TARGETARCH" = "amd64" ]; \
    then download=$amd_download; file=$amd_file; \
    else download=$arm_download; file=$arm_file; \
    fi && \
    wget -q https://opengauss.obs.cn-south-1.myhuaweicloud.com/3.1.1/$download.tar.gz && \
    mkdir opengauss && \
    tar -xf $file.tar.gz -C /opt/opengauss

WORKDIR /opt/opengauss
