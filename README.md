# Base NFT Contract

A simple, secure ERC-721 contract for deployment on [Base](https://base.org), built on OpenZeppelin's audited, battle-tested libraries.

## Features
- Public mint at a fixed price (owner-adjustable)
- Max supply cap
- Owner-only mint (for team allocation / giveaways)
- Owner withdrawal of collected ETH
- Reentrancy protection
## Requirements
- Node.js v18 or later
- A wallet with some ETH on Base (or Base Sepolia for testing)

## Install

```bash
npm install
cp .env.example .env
# Fill in PRIVATE_KEY and (optionally) BASESCAN_API_KEY in .env
```

## Compile & Test

```bash
npm run compile
npm test
```

## Deploy

Deploy to the testnet (Base Sepolia) first — recommended before mainnet:
```bash
npm run deploy:baseSepolia
```

Deploy to Base mainnet:
```bash
npm run deploy:base
```
## Important notes before a real deployment
1. Replace the `baseURI` in `scripts/deploy.js` with your actual metadata CID (hosted on IPFS).
2. Never commit your private key — `.env` is already in `.gitignore`.
3. Test thoroughly on Base Sepolia before deploying to mainnet.
4. Consider having the contract reviewed by a security professional before real usage.

## Networks
| Network | Chain ID | RPC |
|---|---|---|
| Base Mainnet | 8453 | https://mainnet.base.org |
| Base Sepolia (testnet) | 84532 | https://sepolia.base.org |
