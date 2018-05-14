# grep -l means printing the file name instead of the matching line itself.
# grep -r means recursive.
sed -i "s/hongchang/hczhang/g" `grep hongchang -rl ./`
