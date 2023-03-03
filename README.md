# CTFs for All Ages

Run `forge test` until all tests (1) passes :3

```bash
# To compile the vulnerable contract, you need solc 0.4.0
solc --bin-runtime src/CTF.sol4

# Check if you've captured the flag
forge test
```


---

<details>
    <summary>69 Beers (baby mode)</summary>


A [Bar](src/Bar.sol) is using [VRGDAs](https://www.paradigm.xyz/2022/08/vrgda) to price their beers. Jessy wants to buy a round (69 beers), but only has 1 ether to spend. Can you [game the bar](test/Bar.t.sol) to buy the round?

---

## Rules:

1. Only modify `testBuy69Beers()` in [Bar.t.sol](test/Bar.t.sol) in the designated section.

2. **Do not use cheatcodes**

3. Assume the VRGDA *dependency* is correct

3. Get the test to pass!

## Hint:

<details>
<summary>Spoiler! Chads begone!</summary>

VRGDAs set the price of a resource based on *time* and *resources* "purchased so far". As more *resources* are purchased, the price of each *resource* increases.

</details>
  
</details>