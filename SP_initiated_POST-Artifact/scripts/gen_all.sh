#!/bin/bash

# Generate all protocol variants

gpp -H SAML_meta.spthy -o SAML_signed_norelaystate_strongid.spthy
gpp -H SAML_meta.spthy -o SAML_signed_norelaystate_weakid.spthy -D SAML_WEAK_ID
gpp -H SAML_meta.spthy -o SAML_signed_relaystate_strongid.spthy -D SAML_RELAYSTATE
gpp -H SAML_meta.spthy -o SAML_signed_relaystate_weakid.spthy -D SAML_WEAK_ID -D SAML_RELAYSTATE
gpp -H SAML_meta.spthy -o SAML_unsigned_norelaystate_strongid.spthy -D SAML_UNSIGNED_AUTHNREQUEST
gpp -H SAML_meta.spthy -o SAML_unsigned_norelaystate_weakid.spthy -D SAML_WEAK_ID -D SAML_UNSIGNED_AUTHNREQUEST
gpp -H SAML_meta.spthy -o SAML_unsigned_relaystate_strongid.spthy -D SAML_RELAYSTATE -D SAML_UNSIGNED_AUTHNREQUEST
gpp -H SAML_meta.spthy -o SAML_unsigned_relaystate_weakid.spthy -D SAML_WEAK_ID -D SAML_RELAYSTATE -D SAML_UNSIGNED_AUTHNREQUEST
