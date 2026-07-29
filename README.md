# Base NFT Contract

قرارداد ساده و امن ERC-721 برای دیپلوی روی شبکه [Base](https://base.org)، ساخته‌شده روی کتابخانه‌های استاندارد و تست‌شده OpenZeppelin.

## امکانات
- Mint عمومی با قیمت ثابت (قابل تغییر توسط owner)
- سقف عرضه (Max Supply)
- Mint اختصاصی owner (برای تیم/گیواوی)
- برداشت ETH جمع‌شده توسط owner
- محافظت در برابر Reentrancy

## پیش‌نیاز
- Node.js نسخه ۱۸ یا بالاتر
- یک کیف پول با کمی ETH روی Base (یا Base Sepolia برای تست)

## نصب

```bash
npm install
cp .env.example .env
# مقدار PRIVATE_KEY و در صورت تمایل BASESCAN_API_KEY رو داخل .env بذار
```

## کامپایل و تست

```bash
npm run compile
npm test
```

## دیپلوی

دیپلوی روی شبکه تست (Base Sepolia) — پیشنهاد می‌شود اول اینجا تست کنید:
```bash
npm run deploy:baseSepolia
```

دیپلوی روی Base اصلی (mainnet):
```bash
npm run deploy:base
```

## نکات مهم قبل از دیپلوی واقعی
1. آدرس `baseURI` را در `scripts/deploy.js` با CID متادیتای واقعی (روی IPFS) جایگزین کنید.
2. کلید خصوصی (`PRIVATE_KEY`) را هرگز commit نکنید؛ فایل `.env` در `.gitignore` قرار دارد.
3. قبل از mainnet، حتماً روی Base Sepolia تست کامل انجام دهید.
4. توصیه می‌شود قرارداد را قبل از استفاده واقعی توسط یک متخصص امنیت بازبینی (audit) کنید.

## شبکه‌ها
| شبکه | Chain ID | RPC |
|---|---|---|
| Base Mainnet | 8453 | https://mainnet.base.org |
| Base Sepolia (testnet) | 84532 | https://sepolia.base.org |
