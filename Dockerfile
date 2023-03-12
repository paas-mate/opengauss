FROM shoothzj/base:openeuler

RUN dnf install -yq util-linux && \
    dnf install -y libaio && \
    dnf clean all

RUN groupadd gauss -g 777 && \
    useradd -r -g gauss gauss -u 777 -m -d /opt/gauss && \
    touch /opt/gauss/.bashrc

RUN ln -s /usr/lib64/libreadline.so.8 /usr/lib64/libreadline.so.7;

USER gauss

WORKDIR /opt/gauss

ARG TARGETARCH
ARG amd_download=x86_openEuler/openGauss-3.1.1-openEuler-64bit-all
ARG arm_download=arm/openGauss-3.1.1-openEuler-64bit-all

RUN if [ "$TARGETARCH" = "amd64" ]; \
    then download=$amd_download; \
    else download=$arm_download; \
    fi && \
    wget -q https://opengauss.obs.cn-south-1.myhuaweicloud.com/3.1.1/$download.tar.gz && \
    tar -xf openGauss-3.1.1-openEuler-64bit-all.tar.gz -C /opt/gauss && \
    rm -rf openGauss-3.1.1-openEuler-64bit-all.tar.gz && \
    mkdir /opt/gauss/cm && \
    mkdir /opt/gauss/om && \
    mkdir /opt/gauss/gauss && \
    tar -xf openGauss-3.1.1-openEuler-64bit-cm.tar.gz -C /opt/gauss/cm && \
    tar -xf openGauss-3.1.1-openEuler-64bit-om.tar.gz -C /opt/gauss/om && \
    tar -xf openGauss-3.1.1-openEuler-64bit.tar.bz2 -C /opt/gauss/gauss && \
    rm -rf openGauss-3.1.1-openEuler-64bit-cm.tar.gz && \
    rm -rf openGauss-3.1.1-openEuler-64bit-om.tar.gz && \
    rm -rf openGauss-3.1.1-openEuler-64bit.tar.bz2 && \
    rm -rf openGauss-3.1.1-openEuler-64bit-cm.sha256 && \
    rm -rf openGauss-3.1.1-openEuler-64bit-om.sha256 && \
    rm -rf openGauss-3.1.1-openEuler-64bit.sha256

COPY hack/install.sh /opt/gauss/gauss/simpleInstall/install.sh
