# platform = multi_platform_sle
# reboot = false
# strategy = enable
# complexity = low
# disruption = low

SMARTCARD_PACKAGES=( "pam_pkcs11"  "mozilla-nss"  "mozilla-nss-tools"  "pcsc-ccid"  "pcsc-lite"  "pcsc-tools"  "opensc")
{{% if product not in ["sle15"] %}}
SMARTCARD_PACKAGES+=("coolkey")
{{% endif %}}

for PKGNAME in "${SMARTCARD_PACKAGES[@]}"
do
    {{{ bash_package_install(package=PKGNAME) }}}
done
