# PSI4 Dockerfile
#
# credits to:
#
# https://github.com/cgsanchez/ScienceContainers/Psi4
# https://hub.docker.com/r/paesanilab/psi4/dockerfile

FROM continuumio/miniconda3:4.4.10

# add first the psi4 channel and then the psi4/agg channel, so that the second has higher priority

RUN conda install --yes psi4 psi4-rt -c psi4/label/agg -c psi4 && \
    conda clean -tipsy

# required directories
RUN for MNTPOINT in \
        /cvmfs \
        /hadoop \
        /hdfs \
        /lizard \
        /mnt/hadoop \
        /mnt/hdfs \
        /xenon \
        /spt \
        /stash2 \
    ; do \
        mkdir -p $MNTPOINT ; \
    done

# singularity stuff
COPY .singularity.d /.singularity.d
RUN cd / && \
    ln -s .singularity.d/actions/exec .exec && \
    ln -s .singularity.d/actions/run .run && \
    ln -s .singularity.d/actions/test .shell && \
    ln -s .singularity.d/runscript singularity

# build info
RUN echo "Timestamp:" `date --utc` | tee /image-build-info.txt

