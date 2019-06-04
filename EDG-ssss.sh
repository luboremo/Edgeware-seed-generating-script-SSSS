cat mnemonic.txt | ssss-split -t3 -n5 > shamir.txt								# Encrypts mnemonic with Shamirs secret sharing scheme, -t <minimum number of shares needed to reconstruct the secret> -n <number of shares>								
cat shamir.txt
