Name:           server-administration-tools
Version:        1.0.0
Release:        1
Summary:        Server administration tools for CentOS

Group:          haakma.org
BuildArch:      noarch
License:        GPL
URL:            https://github.com/sidohaakma/server-administration-tools.git
Source0:        server-administration-tools.tar.gz

%description
Scripts for SSH tunneling and key-sharing, time management, backup and archiving

%prep
%setup -q
%build
%install
install -m 0755 -d $RPM_BUILD_ROOT/src/archive/archive.bash

%files
/etc/sat
/usr/share/sat/archive/archive.bash

%pos
ln -f -s /usr/share/sat/archive.bash /usr/local/bin/archive

%changelog
* Tue Oct 24 2017 Sido Haakma  1.0.0
  - Initial rpm release