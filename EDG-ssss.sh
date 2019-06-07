cat mnemonic.txt | ssss-split -t3 -n5 > shamir.txt						
sed -n '1,2p' shamir.txt > 1stShare.txt | sed -n '3p' shamir.txt > 2ndShare.txt | sed -n '4p' shamir.txt > 3rdShare.txt | sed -n '5p' shamir.txt > 4thShare.txt | sed -n '6p' shamir.txt > 5thShare.txt
