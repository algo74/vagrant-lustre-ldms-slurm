#!/bin/bash

echo "--- Installing tools needed to build LDMS"
set -xe

yum -y install autoconf openssl-devel \
  automake libtool make bison flex \
  git
  # libevent libevent-devel  doxygen gettext swig   readline-devel readline glib2-devel swig libcurl libcurl-devel munge-devel munge-libs perl-ExtUtils-MakeMaker pam-devel rpm-build perl-DBI perl-Switch munge mariadb-devel python3 python-devel python3-devel libuuid-devel
  # autogen

# yum -y groupinstall "Development Tools"

# yum -y install gtk2-devel

# pip3 install Cython numpy

