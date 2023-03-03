# CTFs for All Ages

Run `forge test` until all tests (1) passes :3

```bash
# To compile the vulnerable contract, you need solc 0.4.0
solc --bin-runtime src/CTF.sol4

# Check if you've captured the flag
forge test
```