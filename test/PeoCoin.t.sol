// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "forge-std/Test.sol"; // Foundry's testing library
import "../src/PeoCoin.sol"; // Import the PeoCoin contract

contract PeoCoinTest is Test {
    PeoCoin private token;
    address private owner;
    address private feeCollector;
    address private user1;
    address private user2;

    function setUp() public {
        owner = address(this);
        feeCollector = address(0xFeeCollector); // Mock fee collector address
        user1 = address(0xUser1); // Mock user1 address
        user2 = address(0xUser2); // Mock user2 address

        // Deploy the PeoCoin contract with an initial supply of 1,000,000 tokens
        token = new PeoCoin(1_000_000 ether, feeCollector, 2, owner); // 2% fee
    }

    function testInitialSupply() public {
        assertEq(token.totalSupply(), 1_000_000 ether, "Initial supply mismatch");
        assertEq(token.balanceOf(owner), 1_000_000 ether, "Owner balance mismatch");
    }

    function testSetFeeCollector() public {
        token.setFeeCollector(user1);
        assertEq(token.feeCollector(), user1, "Fee collector not updated");
    }

    function testSetFeePercentage() public {
        token.setFeePercentage(5);
        assertEq(token.feePercentage(), 5, "Fee percentage not updated");
    }

    function testTransferWithFee() public {
        // Transfer 100 tokens from owner to user1
        uint256 transferAmount = 100 ether;
        uint256 expectedFee = (transferAmount * 2) / 100; // 2% fee
        uint256 amountAfterFee = transferAmount - expectedFee;

        token.transfer(user1, transferAmount);

        assertEq(token.balanceOf(user1), amountAfterFee, "Incorrect balance for user1");
        assertEq(token.balanceOf(feeCollector), expectedFee, "Incorrect fee balance");
    }

    function testTransferFromWithFee() public {
        // Approve user2 to spend 200 tokens on behalf of owner
        token.approve(user2, 200 ether);

        // Transfer 200 tokens from owner to user1 via user2
        vm.prank(user2);
        uint256 transferAmount = 200 ether;
        uint256 expectedFee = (transferAmount * 2) / 100; // 2% fee
        uint256 amountAfterFee = transferAmount - expectedFee;

        token.transferFrom(owner, user1, transferAmount);

        assertEq(token.balanceOf(user1), amountAfterFee, "Incorrect balance for user1");
        assertEq(token.balanceOf(feeCollector), expectedFee, "Incorrect fee balance");
    }

    function testMint() public {
        uint256 mintAmount = 500 ether;
        token.mint(user1, mintAmount);
        assertEq(token.balanceOf(user1), mintAmount, "Minted amount mismatch");
        assertEq(token.totalSupply(), 1_000_500 ether, "Total supply mismatch after mint");
    }

    function testBurn() public {
        uint256 burnAmount = 100 ether;
        token.burn(burnAmount);
        assertEq(token.balanceOf(owner), 1_000_000 ether - burnAmount, "Burned amount mismatch");
        assertEq(token.totalSupply(), 1_000_000 ether - burnAmount, "Total supply mismatch after burn");
    }

    function testFailSetFeePercentageAboveMax() public {
        token.setFeePercentage(11); // Exceeds MAX_FEE_PERCENTAGE
    }

    function testFailSetFeeCollectorZeroAddress() public {
        token.setFeeCollector(address(0)); // Invalid fee collector
    }
}
