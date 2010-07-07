%define 	modulename pam_cas
%define		_ver 2.0.11_esup_2.0.5
%define		_archive_dir Pam_cas-2.0.11-esup-2.0.4
%define		tarballname Pam_cas-%{_ver}
Summary:	PAM module for authenticating users against CAS (Central Authentication Service)
Name:		pam-%{modulename}
Version:	%{_ver}
Release:	0.1
License:	GPL
Group:		Base
Source0:	http://sourcesup.cru.fr/frs/download.php/1235/%{tarballname}.tar.gz
Source1:	%{name}.Makefile
URL:		http://www.esup-portail.org/consortium/espace/SSO_1B/tech/cas/cas_pam.html
BuildRequires:	pam-devel
BuildRequires:	openssl-devel
BuildRoot:	%{tmpdir}/%{name}-%{version}-root-%(id -u -n)

%description
pam_cas provides means of authenticating users against a JA-SIG CAS server.
See http://www.ja-sig.org/products/cas/ to learn more about CAS.

%prep
%setup -q -n %{_archive_dir}
install %{SOURCE1} sources/Makefile

%build
cd sources
%{__make}

%install
rm -rf $RPM_BUILD_ROOT
install -D sources/pam_cas.so $RPM_BUILD_ROOT/%{_lib}/security/pam_cas.so
install -D pam_cas.conf $RPM_BUILD_ROOT/%{_sysconfdir}/pam_cas.conf

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(644,root,root,755)
%doc README CHANGELOG INSTALL README
%attr(755,root,root) /%{_lib}/security/pam_cas.so
%config(noreplace) /%{_sysconfdir}/pam_cas.conf
