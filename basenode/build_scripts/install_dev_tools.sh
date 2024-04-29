#!/bin/bash

echo "--- Installing Dev tools"
set -xe

yum -y install git libevent libevent-devel autogen doxygen gettext swig openssl-devel autoconf readline-devel readline glib2-devel swig libcurl libcurl-devel munge-devel munge-libs perl-ExtUtils-MakeMaker pam-devel rpm-build perl-DBI perl-Switch munge mariadb-devel python3 python-devel python3-devel libuuid-devel

yum -y groupinstall "Development Tools"

yum -y install gtk2-devel

# Cython 3.0 may be not compatible with PyYAML (2023-08-17)
pip3 install "Cython<3" numpy
