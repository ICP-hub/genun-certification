for ((i=1; i<=100; i++))
do 
    IDENTITY=$(dfx identity remove "user$i")
    echo "$IDENTITY"
done
