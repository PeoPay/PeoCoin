# **PeoCoin (PEO)**

PeoCoin is the foundational token of the PeoPay ecosystem, enabling decentralized payments, staking rewards, and governance participation. Designed to bridge the gap between blockchain technology and financial inclusion, PeoCoin powers the next-generation financial ecosystem.

---

## **Overview**
PeoCoin is an ERC-20 token deployed on the Ethereum blockchain. It serves as:
- **A medium of exchange** for seamless crypto-to-fiat and crypto-to-mobile transactions via the PeoPay platform.
- **A staking token** for earning rewards in the PeoProve Protocol.
- **A governance token** for voting on key decisions in the ecosystem.

PeoCoin emphasizes security, scalability, and user accessibility, forming the backbone of the PeoPay ecosystem.

---

## **Features**
1. **Standard ERC-20 Compatibility**:
   - Fully compliant with ERC-20 standards, enabling seamless integration with wallets and exchanges.
2. **Real-World Utility**:
   - Powering payments and staking rewards through PeoPay and PeoProve Protocol.
3. **Governance Integration**:
   - Token holders can participate in governance by voting on proposals for the ecosystem’s development.

---

## **Repository Structure**
```
PeoCoin/
├── foundry.toml       # Foundry configuration for smart contract development
├── lib/               # Dependencies and libraries
├── LICENSE            # License for the project
├── README.md          # Project documentation
├── script/            # Deployment scripts for the PeoCoin contract
│   └── Deploy.s.sol   # Deployment logic
├── src/               # Source code for the PeoCoin smart contract
│   └── PeoCoin.sol    # Core ERC-20 token implementation
├── test/              # Unit tests for PeoCoin functionality
│   └── PeoCoin.t.sol  # Test cases for the PeoCoin contract
```

---

## **Development**
This repository uses **Foundry** as the smart contract development framework. Foundry provides robust tools for compiling, testing, and deploying Ethereum-based smart contracts.

### **Requirements**
- Foundry installed. ([Installation Guide](https://book.getfoundry.sh/getting-started/installation))
- Node.js (optional, for auxiliary scripts or integrations).

---

### **Setup**
1. Clone the repository:
   ```bash
   git clone https://github.com/PeoPay/PeoCoin.git
   cd PeoCoin
   ```
2. Install dependencies:
   ```bash
   forge install
   ```
3. Build the project:
   ```bash
   forge build
   ```
4. Run tests:
   ```bash
   forge test
   ```


## **Testing**
Unit tests for the PeoCoin contract are included in the `test` directory. Use Foundry’s testing suite to ensure functionality:
```bash
forge test
```

---

## **Contributing**
Contributions are welcome! To contribute:
1. Fork the repository.
2. Create a new branch:
   ```bash
   git checkout -b feature-name
   ```
3. Commit your changes and submit a pull request.

---

## **License**
This project is licensed under the GNU Gpl3 License. See the [LICENSE](LICENSE) file for more details.

---

## **Contact**
For questions, issues, or contributions, please contact the team at:
- **Website**: [peopay.io](https:/peopay.io)
- **Email**: support@peopay.io
