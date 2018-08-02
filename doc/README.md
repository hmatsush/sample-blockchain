### 7章　Solidityによるアプリケーション開発
この章ではSolidityとRemixを使ったスマートコントラクト開発について記述されている。
- Solidity  
スマートコントラクト開発をするために生まれたJSライクな静的型付け言語

- Remix  
ブラウザベースのIDE  
[http:remix.ethereum.org/](http:remix.ethereum.org/)

- RemixとGethの接続  
前章で記述されたプライベートネットとの結合

以下のコマンド
```
$ sh install.sh
$ sh setup.sh
$ sh start.sh
```

本章後半はSolidityの文法に関する説明がのってます。
本や[公式ドキュメント](http://solidity.readthedocs.io/en/develop/index.html)に記載されているため割愛します。

### 8章　アプリケーション開発のフレームワーク
#### Truffle
jsでスマートコントラクトを開発する方法について記述されている。
- Truffle  
フレームワーク

```
$ npm install -g truffle
$ mkdir myproject
$ cd myproject
$ truffle init
$ tree
.
├── contracts
│   └── Migrations.sol
├── migrations
│   └── 1_initial_migration.js
├── test
├── truffle-config.js
└── truffle.js
```
contracts スマートコントラクトのディレクトリ
migrations スクリプトで記述できるデプロイメントファイルのディレクト
test テストファイルのディレクトリ
truffle.js Truffleの設定ファイル
truffle-config.js Truffleの設定ファイルの雛形

#### イーサリアムクライアント
- Ganache  
[https://truffleframework.com/ganache](https://truffleframework.com/ganache)

- Truffle Develo

```
$ truffle develop
Truffle Develop started at http://127.0.0.1:9545/

Accounts:
(0) ****
(1) ****
(2) ****
(3) ****
(4) ****
(5) ****
(6) ****
(7) ****
(8) ****
(9) ****

Private Keys:
(0) ****
(1) ****
(2) ****
(3) ****
(4) ****
(5) ****
(6) ****
(7) ****
(8) ****
(9) ****

Mnemonic: candy maple cake sugar pudding cream honey rich smooth crumble sweet treat

⚠️  Important ⚠️  : This mnemonic was created for you by Truffle. It is not secure.
Ensure you do not use it on production blockchains, or else you risk losing funds.

truffle(develop)> compile
truffle(develop)> Compiling ./contracts/Migrations.sol...
Writing artifacts to ./build/contracts

truffle(develop)>
```

```
$ truffle compile
$ truffle migrate
```

#### 公式サンプル
```
$ mkdir metacoin
$ cd metacoin/
$ truffle unbox metacoin
```
[https://truffleframework.com/boxes](https://truffleframework.com/boxes)

```
truffle(develop)> compile
truffle(develop)> migrate
truffle(develop)> m = MetaCoin.at("0xf25186b5081ff5ce73482ad761db0eb0d25abfbf")
truffle(develop)> m.getBalance(web3.eth.accounts[0])
truffle(develop)> m.getBalance(web3.eth.accounts[1])
truffle(develop)> m.sendCoin(web3.eth.accounts[1], 1000)
truffle(develop)> m.getBalance(web3.eth.accounts[0])
truffle(develop)> m.getBalance(web3.eth.accounts[1])
truffle(develop)> test
Using network 'develop'.

Compiling ./contracts/ConvertLib.sol...
Compiling ./contracts/MetaCoin.sol...
Compiling ./test/TestMetacoin.sol...
Compiling truffle/Assert.sol...
Compiling truffle/DeployedAddresses.sol...


  TestMetacoin
    ✓ testInitialBalanceUsingDeployedContract (78ms)
    ✓ testInitialBalanceWithNewMetaCoin (71ms)

  Contract: MetaCoin
    ✓ should put 10000 MetaCoin in the first account
    ✓ should call a function that depends on a linked library
    ✓ should send coin correctly (102ms)


  5 passing (994ms)
```

#### ERC20準拠のトークン作成
- ERC20  
イーサリアム上のトークを標準化する仕様  
また、ERC20に準拠するトークンをERC20準拠トークンと呼ぶ  
ERC20に準拠することで異なるトークン同士でのやりとりが簡単になり、ERC20対応のウォレットでの取り扱いが可能となる。

```
$ mkdir dapps-token
$ cd dapps-token
$ truffle init
$ npm init -f
$ npm install zepplin-solidity
$ truffle develop
truffle(develop)> test
Using network 'develop'.

  Contract: DappsToken
    ✓ should put 1000 DappsToken in the first account

  1 passing (56ms)

truffle(develop)> dappsToken = DappsToken.at(DappsToken.address)
truffle(develop)> dappsToken.balanceOf(web3.eth.accounts[0])
BigNumber { s: 1, e: 3, c: [ 1000 ] }
truffle(develop)> dappsToken.balanceOf(web3.eth.accounts[1])
BigNumber { s: 1, e: 0, c: [ 0 ] }
truffle(develop)> dappsToken.transfer(web3.eth.accounts[1], 100)
truffle(develop)> dappsToken.balanceOf(web3.eth.accounts[0])
BigNumber { s: 1, e: 2, c: [ 900 ] }
truffle(develop)> dappsToken.balanceOf(web3.eth.accounts[1])
BigNumber { s: 1, e: 2, c: [ 100 ] }
truffle(develop)> 
```

#### ネットワークへデプロイ
```
$ sh start.sh
> personal.newAccount("password")
"0x21b4d1334981985fdb1762ffcac3397a38afade2"
> personal.newAccount("password")
"0xcb6267888b9dc57f502c83a7bfce618540c5bd5e"
> personal.newAccount("password")
"0xe458fa964057a4ad17ad473c83e635409bc51bf9"
> miner.start(1)
null
> eth.mining
true
> personal.unlockAccount(eth.accounts[0])
Unlock account 0x21b4d1334981985fdb1762ffcac3397a38afade2
Passphrase: 
true
> personal.unlockAccount(eth.accounts[1])
Unlock account 0xcb6267888b9dc57f502c83a7bfce618540c5bd5e
Passphrase: 
true
> personal.unlockAccount(eth.accounts[2])
Unlock account 0xe458fa964057a4ad17ad473c83e635409bc51bf9
Passphrase: 
true
> exit

# dapps-token dirに移動
$ truffle migrate --network development
Running migration: 1_initial_migration.js
  Deploying Migrations...
  ... 0x581209f3e43004139d481efd744f83efa769dc6d1b860b53ec4bb2d17d745d1b
  Migrations: 0x2a111be336e2a250874e6c05d30aea3776c68e29
Saving successful migration to network...
  ... 0xf3cf9b53c8172fbbe6fa82cf27f71d286dd38144c0aca7f609cf167de51bff51
Saving artifacts...
Running migration: 2_deploy_dapps_token.js
  Deploying DappsToken...
  ... 0x4d8d811ffc3c350cb7d83c355476ec2c406654546d96a2991d66d243c4e30d3e
  DappsToken: 0x654fdc0a52e47d567d8cbdb508794169f0d12eac
Saving successful migration to network...
  ... 0x8f13ad4f2d029008417bb60d4b793bc7820bd6f6b8ea04d74ee65d44178f0f56
Saving artifacts...
$ truffle console --network development
truffle(development)> d = DappsToken.at("0x654fdc0a52e47d567d8cbdb508794169f0d12eac")
truffle(development)> d.name()
'DappsToken'
truffle(development)> d.symbol()
'DTKN'
truffle(development)> d.balanceOf(web3.eth.accounts[0])
BigNumber { s: 1, e: 3, c: [ 1000 ] }
truffle(development)> d.balanceOf(web3.eth.accounts[1])
BigNumber { s: 1, e: 0, c: [ 0 ] }
truffle(development)> d.balanceOf(web3.eth.accounts[2])
BigNumber { s: 1, e: 0, c: [ 0 ] }
truffle(development)> d.transfer(web3.eth.accounts[1], 100)
{ tx: '0x89fcab144608446f11d20ab543256c05e68ef7d1ecf5712c263c7347c66e73ad',
  receipt: 
   { blockHash: '0x77a5d65b94125fc662722c5871455ed0277db07a71f6a4d9e45f8f07d69c4a5a',
     blockNumber: 422,
     contractAddress: null,
     cumulativeGasUsed: 51547,
     from: '0x21b4d1334981985fdb1762ffcac3397a38afade2',
     gasUsed: 51547,
     logs: [ [Object] ],
     logsBloom: '0x00000000000000000000000000000000000000000400000000000000000000000000100000000000000000004800000000000000000000000000000000000000000000000000000000000008000000000000000000000000000000000000000000000400000002000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002000000000000100000000000000000000000000000000000000020000000000000000000000000000000000000000000000000004000000000000000',
     root: '0x4308331731be09caa8598e0cf1b9d44f1aed89a8aef01085f3bfad245d3484c3',
     to: '0xa3d9c3ea47fa93c67e2cb4936c1cf0144a1dc32f',
     transactionHash: '0x89fcab144608446f11d20ab543256c05e68ef7d1ecf5712c263c7347c66e73ad',
     transactionIndex: 0 },
  logs: 
   [ { address: '0xa3d9c3ea47fa93c67e2cb4936c1cf0144a1dc32f',
       blockNumber: 422,
       transactionHash: '0x89fcab144608446f11d20ab543256c05e68ef7d1ecf5712c263c7347c66e73ad',
       transactionIndex: 0,
       blockHash: '0x77a5d65b94125fc662722c5871455ed0277db07a71f6a4d9e45f8f07d69c4a5a',
       logIndex: 0,
       removed: false,
       event: 'Transfer',
       args: [Object] } ] }
truffle(development)> d.balanceOf(web3.eth.accounts[0])
BigNumber { s: 1, e: 2, c: [ 900 ] }
truffle(development)> d.balanceOf(web3.eth.accounts[1])
BigNumber { s: 1, e: 2, c: [ 100 ] }
truffle(development)> d.balanceOf(web3.eth.accounts[2])
BigNumber { s: 1, e: 0, c: [ 0 ] }
```
