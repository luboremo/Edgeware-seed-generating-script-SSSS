#!/bin/bash
sudo apt-get install secure-delete
srm mnemonic.txt
srm inspectedMnemonic.txt
srm public.txt
srm array1.txt
srm array2.txt
srm stashDerivation.txt
srm StashPubkey.txt
srm controllerDerivation.txt
srm ControllerPubkey.txt
srm authorityDerivation.txt
srm AuthorityPubkey.txt
srm comparisonResult.txt
srm PubKeys.txt
srm shamir.txt
srm 1stShare.txt
srm 2ndShare.txt
srm 3rdShare.txt
srm 4thShare.txt
srm 5thShare.txt
# sfill -v /home    # Use this command only if you have dedicated cloud server or computer where you plan to reinstall the operating system (or delete the server)
