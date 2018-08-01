#!/bin/bash
geth --networkid "10" --nodiscover --datadir ./eth_private_net --rpc --rpcaddr "localhost" --rpcport "8545" --rpccorsdomain "*" --rpcapi "eth,net,web3,personal" --targetgaslimit "20000000" console 2>> ./eth_private_net/error.log
