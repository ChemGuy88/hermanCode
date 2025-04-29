# Sorting Files by Creation Date

<!-- Created Tue Apr 15 22:25:21 2025 -->

On macOS you can do

```zsh
cd "data/output/websocket_download_data/2025-04-15 20-03-19"
stat -f "%SB : %N" -t "%Y-%m-%d %H-%M-%S" * | sort -k 1
```

To get something like this:

```text
2025-04-15 20-03-52 : FET-USD.JSON
2025-04-15 20-03-52 : LTC-USD.JSON
2025-04-15 20-03-53 : BTC-GBP.JSON
2025-04-15 20-03-53 : INJ-USD.JSON
2025-04-15 20-03-54 : BONK-USDC.JSON
2025-04-15 20-03-54 : LINK-USDC.JSON
2025-04-15 20-03-56 : STX-USD.JSON
2025-04-15 20-03-59 : ETH-EUR.JSON
2025-04-15 20-04-12 : 00-USDC.JSON
2025-04-15 20-04-12 : ATOM-USDT.JSON
```
