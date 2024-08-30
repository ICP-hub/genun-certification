#!/bin/bash

# Set the canister name
CANISTER_NAME="icrc7"

# Define the principal for owners (for testing purposes, we'll use the same principal for all)
PRINCIPAL="2vxsx-fae"

# Define base data
BASE_NAME="Token"
BASE_DESCRIPTION="This is a description for"
BASE_LOGO="Logo"

# Define the number of users and records per command
NUM_USERS=100
BATCH_SIZE=10

# Generate and execute commands
for ((i=0; i<NUM_USERS; i+=BATCH_SIZE)); do
  owners="vec {"
  names="vec {"
  descriptions="vec {"
  logos="vec {"

  # Generate data for 10 records
  for ((j=0; j<BATCH_SIZE; j++)); do
    index=$((i + j + 1))

    owners+="record { owner = principal \"$PRINCIPAL\"; subaccount = null }; "
    names+="\"$BASE_NAME $index\"; "
    descriptions+="opt \"$BASE_DESCRIPTION $BASE_NAME $index\"; "
    logos+="opt \"$BASE_LOGO $index\"; "
  done

  # Close vectors
  owners+="}"
  names+="}"
  descriptions+="}"
  logos+="}"

  # Construct the dfx command
  CMD="dfx canister call $CANISTER_NAME mint_batch '(record { owners = $owners; names = $names; descriptions = $descriptions; logos = $logos })'"

  # Execute the command
  echo "Executing command for users $((i+1)) to $((i+BATCH_SIZE))..."
  eval $CMD

  # Wait for a short period to avoid overwhelming the system (optional)
  sleep 1
done

echo "Batch minting process completed."
