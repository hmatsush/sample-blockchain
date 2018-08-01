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
