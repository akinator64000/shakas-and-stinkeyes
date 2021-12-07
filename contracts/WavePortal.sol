// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract ShakasAndStinkeyes {
    uint256 totalShakas;
    uint256 totalStinkeyes;
    uint private seed;

    event NewMessage(address indexed from, uint256 timestamp, string message);

    struct Message {
        address waver;
        string message;
        uint256 timestamp;
    }

    Message[] messages;

    // Storing info for cooldown check
    mapping(address => uint256) public lastWavedAt;

    constructor() payable {
        console.log("I am a very smart (and now paying) contract.");
        // Set initial seed
        seed = (block.timestamp + block.difficulty) % 100;
    }

    function shaka(string memory _message) public {
        
        //Cool down check
        require(
            lastWavedAt[msg.sender] + 30 seconds < block.timestamp,
            "Wait 30 seconds."
        );

        lastWavedAt[msg.sender] = block.timestamp;
        
        totalShakas++;
        console.log("%s dropped a shaka!", msg.sender);
        messages.push(Message(msg.sender, _message, block.timestamp));
        emit NewMessage(msg.sender, block.timestamp, _message);

        seed = (block.difficulty + block.timestamp + seed) % 100;

        console.log("Seed: %d", seed);

        if (seed <= 50) {
            console.log("%s has won!", msg.sender);
            uint256 prizeAmount = 0.0001 ether;
            require(
                prizeAmount <= address(this).balance,
                "Trying to withdraw more money than this deadbeat contract has. It is smart--not rich."
            );
            (bool sucess, ) = (msg.sender).call{value: prizeAmount}("");
            require(sucess, "Failed to withdraw money from contract. Sucks for you.");
        } else {
            console.log("%s did not win.", msg.sender);
        }
    }

    function getTotalShakas() public view returns (uint256) {
        console.log("We have %d total shakas!", totalShakas);
        return totalShakas;
    }

    function stinkeye(string memory _message) public {
        //Cool down check
        require(
            lastWavedAt[msg.sender] + 30 seconds < block.timestamp,
            "Wait 30 seconds."
        );

        lastWavedAt[msg.sender] = block.timestamp;
        
        totalStinkeyes++;
        console.log("%s shot a stinkeye!", msg.sender);
        messages.push(Message(msg.sender, _message, block.timestamp));
        emit NewMessage(msg.sender, block.timestamp, _message);

        seed = (block.difficulty + block.timestamp + seed) % 100;

        console.log("Seed: %d", seed);

        if (seed <= 50) {
            console.log("%s has won!", msg.sender);
            uint256 prizeAmount = 0.0001 ether;
            require(
                prizeAmount <= address(this).balance,
                "Trying to withdraw more money than this deadbeat contract has. It is smart--not rich."
            );
            (bool sucess, ) = (msg.sender).call{value: prizeAmount}("");
            require(sucess, "Failed to withdraw money from contract. Sucks for you.");
        } else {
            console.log("%s did not win.", msg.sender);
        }
    }

    function getTotalStinkeyes() public view returns (uint256) {
        console.log("We have %d total stinkeyes!", totalStinkeyes);
        return totalStinkeyes;
    }

    function getAllMessages () public view returns (Message[] memory) {
        return messages;
    }
}
