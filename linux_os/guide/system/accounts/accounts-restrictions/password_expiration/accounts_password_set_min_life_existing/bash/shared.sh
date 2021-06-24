# platform = Red Hat Virtualization 4,multi_platform_fedora,multi_platform_ol,multi_platform_rhel
. /usr/share/scap-security-guide/remediation_functions
{{{ bash_instantiate_variables("var_accounts_minimum_age_login_defs") }}}

# only remediate interactive user accounts.
for acct in $(awk -F: '$3 >= 1000 && 
                       $3 != 65534 && 
                       $3 != 65535 &&
                       $3 != 4294967294 && 
                       $3 != 4294967295 { print $1 }' /etc/passwd); do

    # only remediate accounts that are actually failed.
    if [ $(chage -l $acct | awk -F: '/Maximum/ {print $2}') -gt $var_accounts_minimum_age_login_defs ]; then
        chage -M $var_accounts_minimum_age_login_defs $acct
    fi
done
