// SPDX-License-Identifier: GNU
pragma solidity ^0.8.26;

/**
 * @title PeoCoin
 * @dev ERC-20 token with minting, burning, and transaction fee functionality.
 * @author Daniil Krizhanovskyi
 */

import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "openzeppelin-contracts/contracts/access/Ownable.sol";

contract PeoCoin is ERC20, Ownable {
    /// @notice The address where transaction fees are collected
    address public feeCollector;

    /// @notice The transaction fee percentage (e.g., 2 for 2%)
    uint256 public feePercentage;

    /// @dev Maximum fee percentage allowed (e.g., 10%)
    uint256 public constant MAX_FEE_PERCENTAGE = 10;

    /**
     * @notice Constructor to initialize the token
     * @param initialSupply The initial supply of the token (in smallest units)
     * @param _feeCollector The address to collect transaction fees
     * @param _feePercentage The initial transaction fee percentage
     * @param initialOwner The owner of the contract
     */
    constructor(
        uint256 initialSupply,
        address _feeCollector,
        uint256 _feePercentage,
        address initialOwner
    ) ERC20("PeoCoin", "PEO") Ownable(initialOwner) {
        require(_feeCollector != address(0), "Invalid fee collector address");
        require(_feePercentage <= MAX_FEE_PERCENTAGE, "Fee exceeds maximum");

        feeCollector = _feeCollector;
        feePercentage = _feePercentage;

        // Mint initial supply to the deployer
        _mint(msg.sender, initialSupply);
    }

    /**
     * @notice Mint new tokens
     * @param account The address to receive the minted tokens
     * @param amount The amount of tokens to mint
     */
    function mint(address account, uint256 amount) external onlyOwner {
        _mint(account, amount);
    }

    /**
     * @notice Burn tokens from the sender's account
     * @param amount The amount of tokens to burn
     */
    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }

    /**
     * @notice Set a new fee collector address
     * @param _feeCollector The new fee collector address
     */
    function setFeeCollector(address _feeCollector) external onlyOwner {
        require(_feeCollector != address(0), "Invalid fee collector address");
        feeCollector = _feeCollector;
    }

    /**
     * @notice Set a new transaction fee percentage
     * @param _feePercentage The new fee percentage (must be <= MAX_FEE_PERCENTAGE)
     */
    function setFeePercentage(uint256 _feePercentage) external onlyOwner {
        require(_feePercentage <= MAX_FEE_PERCENTAGE, "Fee exceeds maximum");
        feePercentage = _feePercentage;
    }

    /**
     * @dev Override the `transfer` function to apply transaction fees
     */
    function transfer(address recipient, uint256 amount) public override returns (bool) {
        uint256 fee = (amount * feePercentage) / 100;
        uint256 amountAfterFee = amount - fee;

        // Transfer the fee to the fee collector
        if (fee > 0) {
            super.transfer(feeCollector, fee);
        }

        // Transfer the remaining amount to the recipient
        return super.transfer(recipient, amountAfterFee);
    }

    /**
     * @dev Override the `transferFrom` function to apply transaction fees
     */
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public override returns (bool) {
        uint256 fee = (amount * feePercentage) / 100;
        uint256 amountAfterFee = amount - fee;

        // Transfer the fee to the fee collector
        if (fee > 0) {
            super.transferFrom(sender, feeCollector, fee);
        }

        // Transfer the remaining amount to the recipient
        return super.transferFrom(sender, recipient, amountAfterFee);
    }
}