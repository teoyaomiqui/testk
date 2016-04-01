#
# The spec is generated automatically by Fuel Plugin Builder tool
# https://github.com/stackforge/fuel-plugins
#
# RPM spec file for package glancenfs-1.0
#
# Copyright (c) 2016, Apache License Version 2.0, Specify author or company name
#

Name:           glancenfs-1.0
Version:        1.0.7
Url:            https://github.com/openstack/fuel-plugins
Summary:        godly plugin
License:        Apache License Version 2.0
Source0:        glancenfs-1.0.fp
Vendor:         Specify author or company name
BuildRoot:      %{_tmppath}/%{name}-%{version}-build
Group:          Development/Libraries
Release:        1
BuildArch:      noarch
AutoReq:        no

%description
NFS storage for glance

%prep
rm -rf %{name}-%{version}
mkdir %{name}-%{version}

tar -vxf %{SOURCE0} -C %{name}-%{version}

%install
cd %{name}-%{version}
mkdir -p %{buildroot}/var/www/nailgun/plugins/
cp -r glancenfs-1.0 %{buildroot}/var/www/nailgun/plugins/

%clean
rm -rf %{buildroot}

%pre


%post


%preun


%files
/var/www/nailgun/plugins/glancenfs-1.0
