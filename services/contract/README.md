# FRIENDSHIP.DAO Contracts

### install deps

```shell
forge install
```

if you haven't installed foundry yet, follow [the official installation](https://book.getfoundry.sh/getting-started/installation)

### build

```shell
forge build
```

### Deploy

```shell
cp .env.example .env
```

then, setup .env file.

```
GAS_REPORT=true

export INFURA_KEY=

export ETHERSCAN_KEY=

export DEPLOYER_PRIVATE_KEY=

export MNEMONIC=
```

after setup .env file,

```
source .env && pnpm deploy:credential-sepolia
```

**[IMPORTANT NOTE]**
if you want to use DEPLOYER_PRIVATE_KEY instead of using MNEMONIC, then add `--private-key $DEPLOYER_PRIVATE_KEY` on package.json script like below

```
"deploy:credential-sepolia": "forge clean && forge script script/Credential.s.sol --rpc-url sepolia --broadcast --private-key $DEPLOYER_PRIVATE_KEY --etherscan-api-key $ETHERSCAN_KEY --verify"
```
