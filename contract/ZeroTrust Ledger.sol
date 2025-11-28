// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title ZeroTrust Ledger
 * @dev A minimal trustless ledger that allows users to record immutable entries
 *      and verify ownership of those entries.
 */
contract ZeroTrustLedger {
    // Ledger entry structure
    struct Entry {
        address owner;
        string data;
        uint256 timestamp;
    }

    // Array of all entries
    Entry[] public entries;

    // Event emitted when a new entry is added
    event EntryAdded(address indexed owner, uint256 indexed entryId, string data);

    /**
     * @notice Adds a new entry to the ledger.
     * @param data The string data to be stored on-chain.
     * @return entryId The ID of the newly created ledger entry.
     */
    function addEntry(string calldata data) external returns (uint256 entryId) {
        entryId = entries.length;
        entries.push(Entry(msg.sender, data, block.timestamp));

        emit EntryAdded(msg.sender, entryId, data);
    }

    /**
     * @notice Returns a specific entry by ID.
     * @param entryId The ID of the ledger entry.
     */
    function getEntry(uint256 entryId) external view returns (address owner, string memory data, uint256 timestamp) {
        require(entryId < entries.length, "Entry does not exist");
        Entry memory e = entries[entryId];
        return (e.owner, e.data, e.timestamp);
    }

    /**
     * @notice Returns the total number of ledger entries.
     */
    function totalEntries() external view returns (uint256) {
        return entries.length;
    }
}
