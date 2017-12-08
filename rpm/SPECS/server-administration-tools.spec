Name:           server-administration-tools
Version:        1.0.0
Release:        1
Summary:        Server administration tools for CentOS

Group:          haakma-org
BuildArch:      noarch
Requires:       bash
License:        GPL
URL:            https://github.com/sidohaakma/server-administration-tools.git
Source0:        %{name}-%{version}.tar.gz

%description
Scripts for SSH tunneling and key-sharing, time management, backup and archiving

%prep

%build

%install
rm -rf $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT/usr/local/sat/
cp -r src/ $RPM_BUILD_ROOT/usr/local/sat/

%files
/usr/local/sat

%post
ln -f -s /usr/share/sat/archive.bash /usr/local/bin/archive

%changelog
* Tue Oct 24 2017 Sido Haakma  1.0.0
  - Initial rpm release
