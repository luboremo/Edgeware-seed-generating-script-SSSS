#!/bin/bash													
subkey generate > mnemonic.txt  										# Generate the main mnemonic phrase and pubkey 
cat mnemonic.txt > public.txt											# Saving mnemonic and pubkey to other file which wont be further edited, for later comparison
sed -i 's/Phrase `/"/;s/` is account:/"/;2,5d;/^$/d' mnemonic.txt 						# Editing the mnemonic.txt so only seed will be as a string there
cat mnemonic.txt | xargs subkey inspect $1 > inspectedMnemonic.txt						# Calculating the pubkey from the mnemonic and adding to new text file
mapfile -t mnemonicArray < public.txt										# Creating Array from unedited file where the pubkey from original generation process is stored 
mapfile -t inspectMnemArray < inspectedMnemonic.txt								# Creating Array from the file where the pubkey calculated back from mnemonic is stored
( IFS=$'\n'; echo "${inspectMnemArray[1]}" ) > array1.txt							# Outputting pubkey from the Array to a text file
( IFS=$'\n'; echo "${mnemonicArray[2]}" ) > array2.txt								# Outputting pubkey from the second Array to a text file
paste array1.txt array2.txt | while read a b; do [[ $a != "$b" ]]; echo $?; done > comparisonResult.txt		# Comparing the two pubkeys, saving the true/false result in a text file (in the this case the false would be if integer 1 was the output, integer 0 represents true). This is done to make sure that our mnemonic is safely stored and results in the same pubkey as was calculated from it during the initial generation.
if [ `cat comparisonResult.txt` == 0 ]										# Logical statement that outputs error if the previous comparison resulted in false. If true, then it proceed to derivating first wallets (Stash) pubkey. 
then
        cat mnemonic.txt > stashDerivation.txt     								
	sed  -i '/"/s/$/\/\/Stash/' stashDerivation.txt								# Adding derivation path //Stash to the original mnemonic phrase
	cat stashDerivation.txt | xargs subkey inspect $1 > StashPubkey.txt					# Deriving the key	
	sed -i -e "1d" StashPubkey.txt										# Deleting the mnemonic phrase from the file, as it is outputted as a part of the derivation process
	cat mnemonic.txt > controllerDerivation.txt								# Derivation of Controller wallet
	sed  -i '/"/s/$/\/\/Controller/' controllerDerivation.txt
	cat controllerDerivation.txt | xargs subkey inspect $1 > ControllerPubkey.txt
	sed -i -e "1d" ControllerPubkey.txt
	cat mnemonic.txt > authorityDerivation.txt								# Authority derivation										
	sed  -i '/"/s/$/\/\/Authority/' authorityDerivation.txt
	cat authorityDerivation.txt | xargs subkey -e inspect $1 > AuthorityPubkey.txt				# Deriving the Authority key with ED25519 encryption
	sed -i -e "1,2d" AuthorityPubkey.txt
else
   echo "error: keys are not equal"
   EXIT /b
fi
echo "Stash wallet: " > PubKeys.txt										# Adding pubkeys to one file
cat StashPubkey.txt >> PubKeys.txt
echo "Controller wallet: " >> PubKeys.txt
cat ControllerPubkey.txt >> PubKeys.txt
echo "Authority wallet generated with ED25519: " >> PubKeys.txt
cat AuthorityPubkey.txt >> PubKeys.txt
cat PubKeys.txt													# Print all the keys needed for the lockdrop