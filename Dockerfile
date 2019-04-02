FROM opensciencegrid/osgvo-el7:latest

# http://vergil.chemistry.gatech.edu/nu-psicode/install-v1.2.html
RUN cd /tmp && \
    curl "http://vergil.chemistry.gatech.edu/psicode-download/psi4conda-1.2-py36-Linux-x86_64.sh" -o Psi4conda-latest-py36-Linux-x86_64.sh && \
    bash Psi4conda-latest-py36-Linux-x86_64.sh -b -p /opt/conda && \
    (. /opt/conda/bin/activate && psi4 --test)

# singularity stuff
COPY .singularity.d /.singularity.d

# build info
RUN echo "Timestamp:" `date --utc` | tee /image-build-info.txt

