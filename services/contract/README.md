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

### Deployment

after setup .env file,

```
source .env && pnpm run deploy:credentialProxy-sepolia
```

### Upgrade

```
source .env && pnpm run upgrade
```
