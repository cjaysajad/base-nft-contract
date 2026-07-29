// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

/// @title SimpleNFT
/// @notice A minimal, audited-library-based ERC-721 collection meant to be
///         deployed on Base. Supports public minting with a price and max
///         supply cap, plus owner controls for the base metadata URI and
///         withdrawals.
contract SimpleNFT is ERC721, Ownable, ReentrancyGuard {
    uint256 public constant MAX_SUPPLY = 10_000;
    uint256 public mintPrice = 0.001 ether;
    uint256 public totalMinted;

    string private _baseTokenURI;

    event Minted(address indexed to, uint256 indexed tokenId);
    event MintPriceUpdated(uint256 newPrice);
    event BaseURIUpdated(string newBaseURI);

    constructor(
        string memory name_,
        string memory symbol_,
        string memory baseURI_,
        address initialOwner
    ) ERC721(name_, symbol_) Ownable(initialOwner) {
        _baseTokenURI = baseURI_;
    }

    /// @notice Mint one NFT to the caller. Requires exact mint price.
    function mint() external payable nonReentrant {
        require(totalMinted < MAX_SUPPLY, "Max supply reached");
        require(msg.value == mintPrice, "Incorrect ETH sent");

        totalMinted += 1;
        uint256 tokenId = totalMinted;
        _safeMint(msg.sender, tokenId);

        emit Minted(msg.sender, tokenId);
    }

    /// @notice Owner-only mint, e.g. for team allocation or giveaways.
    function ownerMint(address to) external onlyOwner {
        require(totalMinted < MAX_SUPPLY, "Max supply reached");
        totalMinted += 1;
        uint256 tokenId = totalMinted;
        _safeMint(to, tokenId);
        emit Minted(to, tokenId);
    }

    function setMintPrice(uint256 newPrice) external onlyOwner {
        mintPrice = newPrice;
        emit MintPriceUpdated(newPrice);
    }

    function setBaseURI(string calldata newBaseURI) external onlyOwner {
        _baseTokenURI = newBaseURI;
        emit BaseURIUpdated(newBaseURI);
    }

    function _baseURI() internal view override returns (string memory) {
        return _baseTokenURI;
    }

    /// @notice Withdraw the contract's ETH balance to the owner.
    function withdraw() external onlyOwner nonReentrant {
        uint256 balance = address(this).balance;
        require(balance > 0, "Nothing to withdraw");
        (bool sent, ) = payable(owner()).call{value: balance}("");
        require(sent, "Withdraw failed");
    }
}
