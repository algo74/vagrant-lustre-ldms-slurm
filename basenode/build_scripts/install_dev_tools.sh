#!/bin/bash

echo "--- Installing Dev tools"
set -xe

yum -y install git libevent libevent-devel autogen doxygen gettext swig openssl-devel autoconf readline-devel readline glib2-devel swig libcurl libcurl-devel munge-devel munge-libs perl-ExtUtils-MakeMaker pam-devel rpm-build perl-DBI perl-Switch munge mariadb-devel python3 python-devel python3-devel libuuid-devel
 
yum -y groupinstall "Development Tools" 

pip3 install Cython numpy
